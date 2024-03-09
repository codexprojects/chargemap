//
//  SitesMapCoordinator.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import UIKit

final class SitesMapCoordinator {
    var navigationController: UINavigationController
    
    init() {
        navigationController = UINavigationController()
    }
    
    func start() {
        let sitesViewController = SitesMapViewController()
        navigationController.pushViewController(sitesViewController, animated: false)
    }
}
