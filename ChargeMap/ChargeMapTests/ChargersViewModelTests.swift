//
//  ChargersViewModelTests.swift
//  ChargeMapTests
//
//  Created by Ilke Yucel on 09.03.2024.
//

import XCTest
@testable import ChargeMap

final class ChargersViewModelTests: XCTestCase {
    
    var viewModel: ChargersMapDataViewModel!
    var mockChargers: [Charger]!
    
    override func setUp() {
        super.setUp()
        viewModel = ChargersMapDataViewModel(repository: ChargersDataRepository(), siteID: "14gef4567-e89b-e5r3-n456-426614174013")

        mockChargers = [
            Charger(id: "charger_9896",
                    siteID: "14gef4567-e89b-e5r3-n456-426614174013",
                    name: "Charger at Riga Old Town",
                    evses: [EVSE(id: 1, code: "EVSE1")],
                    connectors: [
                        Connector(id: 2248, evseId: 1, power: 50, status: 0),
                        Connector(id: 2973, evseId: 1, power: 22, status: 0)
                    ])
        ]
    }
    
    func testLoadChargersForSite() {
        viewModel.chargers = mockChargers.filter { $0.siteID == viewModel.siteID }
        
        XCTAssertEqual(viewModel.chargers.count, 1)
        XCTAssertEqual(viewModel.chargers.first?.name, "Charger at Riga Old Town")
    }
    
}
