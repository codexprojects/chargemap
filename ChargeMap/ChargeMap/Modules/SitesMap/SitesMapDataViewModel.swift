//
//  SitesMapDataViewModel.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Combine

final class SitesMapDataViewModel {
    @Published var sites: [Site] = []
    
    private let repository: SitesDataRepository
    
    init(repository: SitesDataRepository) {
        self.repository = repository
    }
    
    func fetchSites() async {
        do {
            self.sites = try await repository.fetch()
        } catch {
            print("Error fetching sites: \(error)")
        }
    }
}
