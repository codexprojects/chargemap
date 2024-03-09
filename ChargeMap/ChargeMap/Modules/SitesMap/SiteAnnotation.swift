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
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, site: Site, identifier: String = "SiteAnnotation") {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.site = site
    }
}
