//
//  SiteAnnotation.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation
import MapKit

final class SiteAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var site: Site
    var identifier = "SiteAnnotation"
    
    init(site: Site) {
        self.coordinate = CLLocationCoordinate2D(latitude: site.location.lat, longitude: site.location.lon)
        self.title = site.name
        self.subtitle = site.details
        self.site = site
    }
}
