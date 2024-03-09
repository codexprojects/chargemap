//
//  SitesMapViewController.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import UIKit
import Combine

class SitesMapViewController: UIViewController {
    
    private let viewModel: SitesMapDataViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: SitesMapDataViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        Task {
            await viewModel.fetchSites()
        }
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.$sites
            .sink { sites in
                Task { @MainActor in
                    self.title = "\(sites.count)"
                }
            }
            .store(in: &cancellables)
    }
}
