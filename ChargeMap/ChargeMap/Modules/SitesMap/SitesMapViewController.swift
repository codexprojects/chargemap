//
//  SitesMapViewController.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import UIKit
import Combine
import MapKit

class SitesMapViewController: UIViewController {
    
    private let viewModel: SitesMapDataViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Views
    private var mapView: MKMapView!
    private var annotations = [SiteAnnotation]()
    
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
        Task {
            await viewModel.fetchSites()
        }
        bindViewModel()
    }
    
    // MARK: Data Binding
    private func bindViewModel() {
        viewModel.$sites
            .sink { [weak self] sites in
                Task { @MainActor in
                    self?.title = "\(sites.count)"
                    self?.addAnnotations(for: sites)
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
        print("Locate me!!!")
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
}


//MARK: - MKMapViewDelegate
extension SitesMapViewController: MKMapViewDelegate {}
