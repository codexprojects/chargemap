//
//  SitesViewModelTests.swift
//  ChargeMapTests
//
//  Created by Ilke Yucel on 09.03.2024.
//

import XCTest
@testable import ChargeMap

class SitesViewModelTests: XCTestCase {
    var viewModel: SitesMapDataViewModel!
    var mockSites: [Site]!

    override func setUp() {
        super.setUp()

        let repository = SitesDataRepository()
        viewModel = SitesMapDataViewModel(repository: repository)

        mockSites = [
            Site(id: "14gef4567-e89b-e5r3-n456-426614174013",
                 name: "Riga Old Town",
                 location: Location(lat: 56.9496, lon: 24.1052),
                 details: "The historic and geographic center of Riga, known for its architectural beauty.")
            // Add more sites as needed
        ]
    }

    func testLoadSites() {
        viewModel.sites = mockSites

        XCTAssertEqual(viewModel.sites.count, 1)
        XCTAssertEqual(viewModel.sites.first?.name, "Riga Old Town")
    }
}

