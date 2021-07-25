//
//  ApointmentListTableViewCell.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import UIKit

class AppointmentListTableViewCell: UITableViewCell, CustomRadioButtonControllerDelegate {
    @IBOutlet weak var titleLabel: UILabel!
   
    private var radioButton = CustomRadioButton() // Added the custom radio button to show how it works. It neccessarily do not have any function associated with it.
    var radioButtonController: CustomRadioButtonViewController?
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addSubview(radioButton)
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([radioButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     radioButton.widthAnchor.constraint(equalToConstant: 40.0),
                                     radioButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
    
    // Custom Radio Button style.
    func updateStyle() {
        radioButtonController = CustomRadioButtonViewController(buttons: radioButton)
        radioButtonController?.delegate = self
        radioButton.circleColor = .green
        radioButtonController?.shouldLetDeSelect = true
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        // TODO; Add your functionality here
    }
    

}
