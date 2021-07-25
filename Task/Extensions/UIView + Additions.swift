//
//  UIView + Additions.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import UIKit

extension UIView {
    func addWithInBounds(view: UIView, with insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate([view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.left),
                                     view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -insets.right),
                                     view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom),
                                     view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top)])
    }

}
