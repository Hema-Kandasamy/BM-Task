//
//  PickerView+ToolBar.swift
//  Task
//
//  Created by Mac_Admin on 25/07/21.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import UIKit

extension UITextField {
    func addToolBar() {
        guard let inputView = self.inputView else {
            return
        }
        let yPosition = inputView.frame.origin.y - 20
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: yPosition, width: self.bounds.width, height: self.bounds.height))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        toolBar.items = [doneButton]
        self.inputAccessoryView = toolBar
    }
    
    @objc func doneTapped() {
        self.resignFirstResponder()
    }
 
}
