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
        let repository = SitesDataRepository()
        let sitesMapDataViewModel = SitesMapDataViewModel(repository: repository)
        let sitesViewController = SitesMapViewController(viewModel: sitesMapDataViewModel)
        navigationController.pushViewController(sitesViewController, animated: true)
    }
}
