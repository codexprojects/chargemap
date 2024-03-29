//
//  SitesDataRepository.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation
import RealmSwift

final class SitesDataRepository: Repository {
    private let networkService = NetworkService()
    private let url: URL?

    init() {
        let url = APIEndpoints.sites.url
        self.url = url
    }
    
    // Main fetch function using async/await
    func fetch() async throws -> [Site] {
        do {
            // Try fetching sites from the local database first
            let localSites = try await fetchSitesFromLocalDatabase()
            if !localSites.isEmpty {
                return localSites
            } else {
                // If the local database is empty or fetching failed, fetch from remote
                return try await fetchFromRemoteAndSave()
            }
        } catch {
            // Handle errors or specific cases, like no data available both locally and remotely
            throw error
        }
    }
    
    // Fetch from remote, save to local database, and fetch again from local database
    private func fetchFromRemoteAndSave() async throws -> [Site] {
        guard let url else {
            throw NetworkError.invalidURL
        }
        
        let sites: [Site] = try await networkService.fetch(from: url)
        do {
            try await saveSitesToLocalDatabase(sites)
        }
        return try await fetchSitesFromLocalDatabase() // Fetch updated data from the local DB
    }
    
    // Save fetched sites to the local database
    private func saveSitesToLocalDatabase(_ sites: [Site]) async throws {
        try await MainActor.run {
            do {
                let realmSites = sites.map(SiteRealmModel.init)
                try RealmStorage.shared.save(objects: realmSites)
            } catch {
                throw LocalDatabaseError.failedToSave
            }
        }
    }
    
    // Fetch sites from the local database
    private func fetchSitesFromLocalDatabase() async throws -> [Site] {
        do {
            let siteRealms: Results<SiteRealmModel> = try RealmStorage.shared.fetch(type: SiteRealmModel.self)
            let sites = siteRealms.map(Site.init)
            return Array(sites)
        } catch {
            throw LocalDatabaseError.failedToFetch
        }
        
    }
}
