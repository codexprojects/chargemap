//
//  ChargersDataViewModel.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Combine
import Foundation

struct FetchError: Identifiable {
    let id = UUID()
    let message: String
}

final class ChargersMapDataViewModel: ObservableObject {
    @Published var chargers: [Charger] = []
    @Published var fetchError: FetchError?
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: ChargersDataRepository
    
    let siteID: String
    
    init(repository: ChargersDataRepository, siteID: String) {
        self.repository = repository
        self.siteID = siteID
    }
    
    func fetchChargers() async {
        do {
            let chargers = try await repository.fetch()
            DispatchQueue.main.async {
                self.chargers = chargers
            }
        } catch {
            DispatchQueue.main.async {
                self.fetchError = FetchError(message: error.localizedDescription)
            }
        }
    }
}

