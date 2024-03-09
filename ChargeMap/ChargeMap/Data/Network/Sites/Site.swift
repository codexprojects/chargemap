//
//  Site.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation

struct Location: Decodable {
    let lat: Double
    let lon: Double
}

struct Site: Decodable {
    let id: String
    let name: String
    let location: Location
    let details: String
}