//
//  LocalSite.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import RealmSwift

class SiteRealmModel: Object, Identifiable, Decodable {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var name: String = ""
    @Persisted var location: LocationRealmModel?
    @Persisted var details: String = ""
    
    convenience init(from site: Site) {
        self.init()
        self.id = site.id
        self.name = site.name
        self.location = LocationRealmModel(from: site.location)
        self.details = site.details
    }
}

class LocationRealmModel: Object, Decodable {
    @Persisted var lat: Double = 0.0
    @Persisted var lon: Double = 0.0
    
    convenience init(from location: Location) {
        self.init()
        self.lat = location.lat
        self.lon = location.lon
    }
    
}
