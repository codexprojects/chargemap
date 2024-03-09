//
//  NetworkService.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

final class NetworkService {
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let _ = response as? HTTPURLResponse else {
            throw NetworkError.invalidURL
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
