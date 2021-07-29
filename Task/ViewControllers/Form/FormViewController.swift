//
//  FormViewController.swift
//  Task
//
//  Created by Mac_Admin on 29/07/21.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import UIKit
class FormViewController: UIViewController {
    var viewModel: FormViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        configBinding()
        viewModel?.fetchFromCoreDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let view = self.view as? EditAddressView else {
            fatalError()
        }
        view.delegate = self
        view.render(nil, animated: true)
    }
    
    private func configBinding() {
        viewModel?.data.bind({ (state) in
            guard let view = self.view as? EditAddressView else {
                fatalError()
            }
            view.render(state, animated: true)
        })
    }
}
extension FormViewController: EditAddressViewDelegate {
    func editAddressViewDidCommit(_ view: EditAddressView, with state: FormViewState) {
        viewModel?.saveToCodeData(state: state)
        self.navigationController?.popViewController(animated: true)
    }
    
    func editAddressViewDidCancel(_ view: EditAddressView) {
        self.navigationController?.popViewController(animated: true)
    }

}
