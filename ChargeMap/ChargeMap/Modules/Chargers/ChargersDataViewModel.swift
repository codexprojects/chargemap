//
//  ChargersDataViewModel.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Combine
import Foundation

class ChargersMapDataViewModel: ObservableObject {
    @Published var chargers: [Charger] = []
    private var cancellables = Set<AnyCancellable>()

    private let repository: ChargersDataRepository

    init(repository: ChargersDataRepository) {
        self.repository = repository
    }

    func fetchChargers() async {
        do {
            let chargers = try await repository.fetch()
            DispatchQueue.main.async {
                self.chargers = chargers
            }
        } catch {
            // Handle errors
            print("Error fetching chargers: \(error)")
        }
    }
}

