//
//  CustomButtonViewController.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation
import UIKit

public protocol CustomRadioButtonControllerDelegate: class {
    func didSelectButton(selectedButton: UIButton?)
}

public class CustomRadioButtonViewController : NSObject
{
    // MARK: - Properties
    
    fileprivate var buttonsArray = [UIButton]()
    public weak var delegate : CustomRadioButtonControllerDelegate?
    public var shouldLetDeSelect = false
    
    
    // Init
    public init(buttons: UIButton...) {
        super.init()
        for aButton in buttons {
            aButton.addTarget(self, action: #selector(CustomRadioButtonViewController.pressed(_:)), for: .touchUpInside)
        }
        self.buttonsArray = buttons
    }
    
    // Action
    @objc func pressed(_ sender: UIButton) {
        var currentSelectedButton: UIButton? = nil
        if(sender.isSelected) {
            if shouldLetDeSelect {
                sender.isSelected = false
                currentSelectedButton = nil
            }
        } else {
            for aButton in buttonsArray {
                aButton.isSelected = false
            }
            sender.isSelected = true
            currentSelectedButton = sender
        }
        delegate?.didSelectButton(selectedButton: currentSelectedButton)
    }
    
    //MARK:- Additional functionalities
    
    // Gives currently selected button from array
    func selectedButton() -> UIButton? {
        guard let index = buttonsArray.firstIndex(where: { button in button.isSelected }) else { return nil }
    
        return buttonsArray[index]
    }
}
