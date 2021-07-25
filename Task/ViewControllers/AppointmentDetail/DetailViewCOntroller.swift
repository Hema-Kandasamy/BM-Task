//
//  DetailViewCOntroller.swift
//  Task
//
//  Created by Hemalatha on 24/07/21.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import UIKit

class DetailViewCOntroller: UIViewController {
    
    @IBOutlet var mainView: DetailView!
    private var viewModel: DetailViewModel?
    static func make(with users: [UsersType]) -> DetailViewCOntroller {
        let vc = initFromStoryBoard()
        vc.viewModel = DetailViewModel(users: users)
        return vc
    }

    override func viewDidLoad() {
        self.navigationItem.title =  "User List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let state = viewModel?.fetchState() else {
            return
        }
        mainView.render(state: state)
    }
}
