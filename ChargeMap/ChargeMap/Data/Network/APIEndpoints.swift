//
//  APIEndpoints.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import Foundation

enum APIEndpoints {
    case sites
    case chargers
    
    private var baseURL: String {
        return "https://chargemap-2dd9f-default-rtdb.europe-west1.firebasedatabase.app/"
    }
    
    var url: URL? {
        switch self {
        case .sites:
            return URL(string: baseURL + "sites.json")
        case .chargers:
            return URL(string: baseURL + "chargers.json")
        }
    }
}
