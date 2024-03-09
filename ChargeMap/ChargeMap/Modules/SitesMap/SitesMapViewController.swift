//
//  SitesMapViewController.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import UIKit
import Combine
import MapKit
import CoreLocation

class SitesMapViewController: UIViewController {
    
    private let viewModel: SitesMapDataViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Views
    private var mapView: MKMapView!
    private var annotations = [SiteAnnotation]()
    
    var userCoordinate: CLLocationCoordinate2D?
    var locationManager: CLLocationManager?
    
    init(viewModel: SitesMapDataViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupLocateMeButton()
        setupLocationManager()
        bindViewModel()
        
        Task {
            await viewModel.fetchSites()
        }
    }
    
    // MARK: Data Binding
    private func bindViewModel() {
        viewModel.$sites
            .sink { [weak self] sites in
                guard let self else { return }
                Task(priority: .userInitiated) { @MainActor in
                    self.title = " Total Points \(sites.count)"
                    self.addAnnotations(for: sites)
                    self.updateMapRegion(rangeSpan: 1000)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - MapView
    private func setupMapView() {
        mapView = MKMapView(frame: view.bounds)
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
    }
    
    func setupLocateMeButton() {
        let locateMeButton = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        // Customize the SF Symbol size using UIImage.SymbolConfiguration
        let symbolSize = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .default)
        let symbolImage = UIImage(systemName: "location.circle.fill", withConfiguration: symbolSize)
        config.image = symbolImage
        locateMeButton.configuration = config
        
        locateMeButton.addTarget(self, action: #selector(locateMeButtonTapped), for: .touchUpInside)
        locateMeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locateMeButton)
        
        NSLayoutConstraint.activate([
            locateMeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            locateMeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func locateMeButtonTapped() {
        if let coordinate = locationManager?.location?.coordinate {
            self.userCoordinate = coordinate
            updateMapRegion(rangeSpan: 1000)
        }
    }
    
    private func addAnnotations(for sites: [Site]) {
        // Remove existing annotations
        mapView.removeAnnotations(annotations)
        annotations.removeAll()
        
        // Create new annotations for the sites
        for site in sites {
            let annotation = SiteAnnotation(site: site)
            annotations.append(annotation)
        }
        
        // Add the new annotations to the map view
        mapView.addAnnotations(annotations)
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
}


//MARK: - MKMapViewDelegate
extension SitesMapViewController: MKMapViewDelegate {
    func updateMapRegion(rangeSpan: CLLocationDistance) {
        guard let userCoordinate else { return }
        let region = MKCoordinateRegion(center: userCoordinate, latitudinalMeters: rangeSpan, longitudinalMeters: rangeSpan)
        mapView.region = region
    }
    
    //MARK: Annotation delegates
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKAnnotationView()
        guard let annotation = annotation as? SiteAnnotation else {
            return nil
        }
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) {
            annotationView = dequeuedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
        }
        
        annotationView.image = UIImage(named: "chargingStation")
        annotationView.canShowCallout = true
        let paragraph = UILabel()
        paragraph.numberOfLines = 0
        paragraph.font = .preferredFont(forTextStyle: .caption1)
        paragraph.text = annotation.subtitle
        annotationView.detailCalloutAccessoryView = paragraph
        annotationView.leftCalloutAccessoryView = UIImageView(image: annotationView.image)
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Handle the tap on the callout accessory
        print("Tapped on the callout accessory")
        guard let annotation = view.annotation as? SiteAnnotation else { return }
        print(annotation.site)
    }
}

//MARK: - CLLocationManagerDelegate
extension SitesMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access granted")
            userCoordinate = manager.location?.coordinate
            updateMapRegion(rangeSpan: 1000)
        case .denied, .restricted:
            print("Location access denied")
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userCoordinate = location.coordinate
    }
}
