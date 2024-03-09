//
//  ChargesDataRepository.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation

final class ChargersDataRepository: Repository {
    private let networkService = NetworkService()
    private let url: URL?

    init() {
        let url = APIEndpoints.chargers.url
        self.url = url
    }
    
    // Main fetch function using async/await
    func fetch() async throws -> [Charger] {
        guard let url = url else {
            throw NetworkError.invalidURL
        }
        
        // Fetch chargers from the remote server
        let chargers: [Charger] = try await networkService.fetch(from: url)
        return chargers
    }
}
