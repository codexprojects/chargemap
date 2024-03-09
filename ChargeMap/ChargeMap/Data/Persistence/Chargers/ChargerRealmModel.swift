//
//  ChargerRealmModel.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import RealmSwift

class ChargerRealmModel: Object {
    @Persisted var id: String = ""
    @Persisted var siteID: String = ""
    @Persisted var name: String = ""
    let evses = List<EVSERealmModel>()
    let connectors = List<ConnectorRealmModel>()

    convenience init(charger: Charger) {
        self.init()
        self.id = charger.id
        self.siteID = charger.siteID
        self.name = charger.name
        self.evses.append(objectsIn: charger.evses.map(EVSERealmModel.init))
        self.connectors.append(objectsIn: charger.connectors.map(ConnectorRealmModel.init))
    }
}

class EVSERealmModel: Object {
    @Persisted var id: Int = 0
    @Persisted var code: String = ""

    convenience init(evse: EVSE) {
        self.init()
        self.id = evse.id
        self.code = evse.code
    }
}

class ConnectorRealmModel: Object {
    @Persisted var id: Int = 0
    @Persisted var evseId: Int = 0
    @Persisted var power: Int = 0
    @Persisted var status: Int = 0

    convenience init(connector: Connector) {
        self.init()
        self.id = connector.id
        self.evseId = connector.evseId
        self.power = connector.power
        self.status = connector.status
    }
}
