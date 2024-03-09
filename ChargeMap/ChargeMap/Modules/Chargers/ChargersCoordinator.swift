//
//  ChargersCoordinator.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import SwiftUI

final class ChargersCoordinator: NSObject, Coordinator, UIViewControllerTransitioningDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var site: Site
    
    init(navigationController: UINavigationController, site: Site) {
        self.navigationController = navigationController
        self.site = site
    }
    
    func start() {
        showChargersList(siteID: self.site.id)
    }
    
    func showChargersList(siteID: String) {
        let viewModel = ChargersMapDataViewModel(repository: ChargersDataRepository(), siteID: self.site.id)
        let chargersListView = ChargersListView(viewModel: viewModel, siteID: siteID)
        let hostingController = UIHostingController(rootView: chargersListView)

        hostingController.modalPresentationStyle = .custom
        hostingController.transitioningDelegate = self

        navigationController.present(hostingController, animated: true)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


class HalfModalPresentationController: UIPresentationController {
    let dimmingView: UIView = UIView()

    override func dismissalTransitionWillBegin() {
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        })
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        return CGRect(x: 0, y: containerView.bounds.height / 2, width: containerView.bounds.width, height: containerView.bounds.height / 2)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)

        dimmingView.alpha = 0
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(_:)))
        dimmingView.addGestureRecognizer(tapRecognizer)
    }

    @objc func dimmingViewTapped(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
