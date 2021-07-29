//
//  Style+UITextField.swift
//  Telenet
//
//  Created by Benedict Cohen on 26/11/2018.
//  Copyright © 2018 Telenet. All rights reserved.
//

import UIKit

enum Style { }
extension Style {

    static func defaultTextField(_ textField: UITextField,
                                 legendLabel: UILabel?,
                                 validationLabel: UILabel?,
                                 underlineColor: UIColor = UIColor.green,
                                 addDoneCancelKeyboardAccessory: Bool = false) {
        // Configure the text field
        textField.textColor = Color.darkerGrey
        textField.font = Font.captionFont
        let willShowValidationWarning = validationLabel != nil
        textField.rightViewMode = willShowValidationWarning ? .always : .never

        if addDoneCancelKeyboardAccessory {
            let toolbar: UIToolbar = UIToolbar()
            toolbar.barStyle = .default
            toolbar.items = [
                UIBarButtonItem(barButtonSystemItem: .cancel, target: textField, action: #selector(UITextField.resignFirstResponder)),
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .done, target: textField, action: #selector(UITextField.resignFirstResponder)),
            ]
            toolbar.sizeToFit()

            textField.inputAccessoryView = toolbar
        }

        // Add the underlineView
        let underlineView = UIView()
        textField.addUnderlineView(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underlineView.heightAnchor.constraint(equalToConstant: 1),
            underlineView.leftAnchor.constraint(equalTo: textField.leftAnchor),
            underlineView.rightAnchor.constraint(equalTo: textField.rightAnchor),
            underlineView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            ])
        // Style the underline view
        underlineView.backgroundColor = underlineColor

        // Configure the legend
        legendLabel?.textColor = Color.mediumGrey
        legendLabel?.font = Font.subTitleFont

        // Configure validation label
        validationLabel?.textColor = Color.red
        validationLabel?.font = Font.subTitleFont
        validationLabel?.text = nil
    }

    static func passwordTextField(_ textField: UITextField, isEnabled: Bool = false) {
        // Configure the text field
        textField.textColor = Color.darkerGrey
        textField.font = Font.subTitleFont
        textField.isEnabled = isEnabled
        textField.isSecureTextEntry = true
    }

    static func searchTextField(_ textField: UITextField, with searchButton: UIButton) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.leftView = leftPaddingView
        textField.font = Font.subTitleFont

        let searchIcon = UIImage(imageLiteralResourceName: "ic_search").withRenderingMode(.alwaysTemplate)
        searchButton.setImage(searchIcon, for: .normal)
        searchButton.tintColor = Color.darkerGrey
        textField.rightView = searchButton
        textField.rightViewMode = .always

    }
}


// MARK: - Underline view helpers

 extension UITextField {

    private static let underlineViewTag = 0xbaff1ed // Using tags is pretty hacky but it's better than the alternatives.

    var underlineView: UIView? {
        return self.viewWithTag(UITextField.underlineViewTag)
    }

    func addUnderlineView(_ underlineView: UIView) {
        underlineView.tag = UITextField.underlineViewTag
        addSubview(underlineView)
        bringSubviewToFront(underlineView)
    }
}
