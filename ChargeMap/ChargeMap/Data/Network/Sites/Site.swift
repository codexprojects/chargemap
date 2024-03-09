//
//  Site.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation

struct Location: Codable {
    let lat: Double
    let lon: Double
}

struct Site: Codable {
    let id: String
    let name: String
    let location: Location
    let details: String
    
    init(from siteRealmModel: SiteRealmModel) {
        id = siteRealmModel.id
        name = siteRealmModel.name
        location = Location(lat: siteRealmModel.location?.lat ?? 0.0, lon: siteRealmModel.location?.lon ?? 0.0)
        details = siteRealmModel.details
    }
}
