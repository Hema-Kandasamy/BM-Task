//
//  DetailView.swift
//  Task
//
//  Created by Hemalatha on 24/07/21.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import UIKit
struct DetailViewState {
    let userName: [String]
}
class DetailView: UIView {
    var state: DetailViewState?
    @IBOutlet weak var usersTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        usersTableView.dataSource = self
    }
    
    func render(state: DetailViewState) {
        self.state = state
        self.usersTableView.reloadData()
    }
}


extension DetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state?.userName.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = state?.userName[indexPath.row]
        return cell
    }
}
