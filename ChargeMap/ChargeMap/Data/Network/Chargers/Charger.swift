//
//  Charger.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation

struct Charger: Codable, Identifiable {
    let id: String
    let siteID: String
    let name: String
    let evses: [EVSE]
    let connectors: [Connector]
    
    init(id: String, siteID: String, name: String, evses: [EVSE], connectors: [Connector]) {
        self.id = id
        self.siteID = siteID
        self.name = name
        self.evses = evses
        self.connectors = connectors
    }

    init(from chargerRealmModel: ChargerRealmModel) {
        id = chargerRealmModel.id
        siteID = chargerRealmModel.siteID
        name = chargerRealmModel.name
        evses = chargerRealmModel.evses.map { EVSE(id: $0.id, code: $0.code) }
        connectors = chargerRealmModel.connectors.map { Connector(id: $0.id, evseId: $0.evseId, power: $0.power, status: $0.status) }
    }
}

struct EVSE: Codable, Identifiable {
    let id: Int
    let code: String
}

struct Connector: Codable, Identifiable {
    let id: Int
    let evseId: Int
    let power: Int
    let status: Int
}

struct Chargers: Codable {
    let chargers: [Charger]
}
