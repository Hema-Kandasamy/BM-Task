//
//  EditAddressView.swift
//  Telenet
//
//  Created by mac_admin on 26/06/21.
//  Copyright © 2018 Telenet. All rights reserved.
//

import UIKit


protocol EditAddressViewDelegate: class {
    func editAddressViewDidCommit(_ view: EditAddressView, with state: FormViewState)
    func editAddressViewDidCancel(_ view: EditAddressView)
}

class EditAddressView: UIView, CustomRadioButtonControllerDelegate {

    // MARK: Properties

    weak var delegate: EditAddressViewDelegate?

    @IBOutlet private var epithetMrButton: CustomRadioButton!
    @IBOutlet private var epithetMrsButton: CustomRadioButton!
    @IBOutlet private var saveButton: UIButton!
    @IBOutlet private var cancelButton: UIButton!

    @IBOutlet private var formStackView: UIStackView!
    private var firstNameFormField: FormField!
    private var lastNameFormField: FormField!
    var radioButtonController: CustomRadioButtonViewController?

    
    // MARK: Instance life cycle

    var isFormEntriesValid: Bool {
        let isFNameValid = firstNameFormField.validate()
        let isLNamevalid = lastNameFormField.validate()
        return isFNameValid && isLNamevalid
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add any validation rules you need
        self.firstNameFormField = FormField(title: "First Name", placeholderText: "Please enter your first name", validationRules: [.maxChar(32), .asciiPrintableChars])
        self.formStackView.addArrangedSubview(self.firstNameFormField)
        self.lastNameFormField = FormField(title: "Last Name", placeholderText: "Please enter your last name", validationRules: [.maxChar(32), .asciiPrintableChars])
        
        self.formStackView.addArrangedSubview(self.lastNameFormField)
        
        // COnfig radio buttons
        radioButtonController = CustomRadioButtonViewController(buttons: epithetMrButton, epithetMrsButton)
        radioButtonController?.delegate = self
        radioButtonController?.shouldLetDeSelect = false
        configStyle(for: epithetMrsButton, title: "Mrs")
        configStyle(for: epithetMrButton, title: "Mr")
        
    }

    private func configStyle(for button: CustomRadioButton, title: String) {
        button.titleEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
    }

    func render(_ state: FormViewState?, animated: Bool) {
        guard let state = state else {
            return
        }
        [epithetMrButton, epithetMrsButton].forEach { $0?.isSelected = false }
        switch state.epithet {
        case .Mr:
            epithetMrButton.isSelected = true
        case .Mrs:
            epithetMrsButton.isSelected = true
        case nil:
            break
        }

        self.firstNameFormField.textField.text = state.firstName
        lastNameFormField.textField.text = state.lastName
    }


    @IBAction private func commit(_ sender: Any) {
        firstNameFormField.textField.resignFirstResponder()
        lastNameFormField.textField.resignFirstResponder()
        
        // Remove any trailing and leading whitespace before validating
        let trimmedFName = firstNameFormField.unwrappedText.trimmingCharacters(in: .whitespaces)
        firstNameFormField.textField.text = trimmedFName
        
        let trimmedLName = lastNameFormField.unwrappedText.trimmingCharacters(in: .whitespaces)
        let epithet = epithetMrsButton.isSelected ? Epithet.Mrs : Epithet.Mr

        if self.isFormEntriesValid {
            let newState =  FormViewState(firstName: trimmedFName, lastName: trimmedLName, epithet: epithet)
            self.delegate?.editAddressViewDidCommit(self, with: newState)
        }
        
    }


    @IBAction private func cancel(_ sender: Any) {
        delegate?.editAddressViewDidCancel(self)
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        // TODO; Add your functionality here
    }
}
