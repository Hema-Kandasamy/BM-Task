//
//  DetailViewModel.swift
//  Task
//
//  Created by Hemalatha on 24/07/21.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation

class DetailViewModel {
    private var users: [UsersType]
    init(users: [UsersType]) {
        self.users = users
    }
    
    func fetchState() -> DetailViewState {
        .init(userName: users.map{ $0.name })
    }
}
