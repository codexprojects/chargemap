//
//  SitesMapCoordinator.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import UIKit

final class SitesMapCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let repository = SitesDataRepository()
        let sitesMapDataViewModel = SitesMapDataViewModel(repository: repository)
        let sitesViewController = SitesMapViewController(viewModel: sitesMapDataViewModel)
        sitesViewController.coordinator = self
        navigationController.pushViewController(sitesViewController, animated: true)
    }
} 
