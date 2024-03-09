//
//  SitesDataRepository.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation
import Combine

final class SitesDataRepository: Repository {
    private let networkService = NetworkService()
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func fetch() async throws -> [Site] {
        do {
            guard let url else {
                throw NetworkError.invalidURL
            }
            
            let sites: [Site] = try await networkService.fetch(from: url)
            return sites
        } catch {
            throw error
        }
    }
}
