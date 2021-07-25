//
//  HomeViewController.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK:- Properties
    @IBOutlet var mainView: HomeView!
    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up viewModel, this usually can be injected or set when we have flow
        self.viewModel = HomeViewModel(with: NetworkSession())
        mainView.viewModel = self.viewModel
        configDataBinding()
        configErrorBinding()
        viewModel?.fetchData()
    }
    private func updateNavigationTitle(with title: String) {
        self.navigationItem.title = title
    }
    // Data Binding
    private func configDataBinding() {
        viewModel?.data.bind{ [weak self] state in
            guard let state = state else { return }
            DispatchQueue.main.async {
                self?.updateNavigationTitle(with: state.title)
                self?.mainView.delegate = self
                self?.mainView.render(state: state)
            }
        }
    }
    private func configErrorBinding() {
        viewModel?.error.bind { error in
            DispatchQueue.main.async {
                self.mainView.renderError(with: error?.localizedDescription ?? "Error occerred")
            }
        }
    }

}


extension HomeViewController: HomeViewDelegate {
    func homeView(_ view: HomeView, didSelectUserWith users: [UsersType]) {
        let vc = DetailViewCOntroller.make(with: users)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

