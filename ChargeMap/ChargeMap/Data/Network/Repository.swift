//
//  Repository.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation

protocol Repository {
    associatedtype T
    func fetchSites(completion: @escaping (Result<[T], Error>) -> Void)
}
