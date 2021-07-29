//
//  FormField.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//
//

import UIKit

//TODO: Move this file to common folder or SharedKit

enum FormFieldValidationMode: Int {
    case edit
    case passed
    case failed
}

class FormTextField: UITextField {
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let size = CGSize(width: 18, height: 18)
        let maxHeight = CGFloat(30.0) // Default textfield height is 30 points
        let yPosition = (maxHeight - size.height) / 2 // Making sure icon is vertically centered
        
        return CGRect(x: bounds.width - size.width,
                      y: yPosition,
                      width: size.width,
                      height: size.height)
    }
}

class FormField: UIStackView {
    
    var title: String
    var placeholderText: String
    var validationRules: [FormFieldValidationRule]
    
    var titleLabel = UILabel.init(frame: .zero)
    var textField = FormTextField.init(frame: .zero)
    var validationLabel = UILabel.init(frame: .zero)
    
    var validationImageView = UIImageView.init(frame: .zero)
    var failureImage: UIImage = #imageLiteral(resourceName: "form-validation-error")
    var successImage: UIImage = #imageLiteral(resourceName: "form-validation-check")
    
    var underlineView = UIView.init(frame: .zero)
    var successColor = UIColor.green
    var failureColor = Color.red
    
    var unwrappedText: String {
        return textField.text ?? ""
    }
    
    fileprivate var currentMode: FormFieldValidationMode = .edit {
        
        didSet {
            if oldValue != currentMode && currentMode == .edit {
                resetToEditMode()
            }
        }
        
    }

    convenience init(title: String,
                     placeholderText: String,
                     validationRules: [FormFieldValidationRule]) {
        self.init(frame: .zero)
        
        self.title = title
        self.placeholderText = placeholderText
        self.validationRules = validationRules
        self.configViews()
    }
        
    
    override init(frame: CGRect) {
        self.title = ""
        self.placeholderText = ""
        self.validationRules = []
        super.init(frame: frame)
    }
    
    
    required init(coder: NSCoder) {
        self.title = ""
        self.placeholderText = ""
        self.validationRules = []
        super.init(coder: coder)
    }

    
     func configViews() {
        self.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8.0
        
        titleLabel.textColor = Color.mediumGrey
        titleLabel.font = Font.subTitleFont
        titleLabel.text = title
        titleLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        addArrangedSubview(titleLabel)
        
        
        textField.textColor = Color.darkerGrey
        textField.font = Font.subTitleFont
        textField.rightViewMode =  .always
        textField.placeholder = placeholderText
        textField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        textField.delegate = self

        textField.addUnderlineView(underlineView)
        
        underlineView.backgroundColor = Color.lightGrey
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underlineView.heightAnchor.constraint(equalToConstant: 1),
            underlineView.leftAnchor.constraint(equalTo: textField.leftAnchor),
            underlineView.rightAnchor.constraint(equalTo: textField.rightAnchor),
            underlineView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            ])

        addArrangedSubview(textField)
        
        validationLabel.textColor = Color.red
        validationLabel.font = Font.subTitleFont
        validationLabel.numberOfLines = 0
        validationLabel.text = nil
        addArrangedSubview(validationLabel)
        
        validationImageView.image = nil
    }
    
    private func resetToEditMode() {
        textField.textColor = Color.darkerGrey
        underlineView.backgroundColor = Color.lightGrey
        validationLabel.text = nil
        
        validationImageView.image = nil
        textField.rightView = validationImageView
    }
    
        
    func validate() -> Bool {
        var isValid = true
        var message = ""
        let enteredText = self.textField.text ?? ""
        
        for rule in validationRules {
            isValid = validate(enteredText: enteredText, with: rule)
            if !isValid {
                message = rule.message
                break
            }
        }
    
        if isValid {
            currentMode = .passed
            textField.textColor = successColor
            underlineView.backgroundColor  = successColor
            validationLabel.text = nil
            
            validationImageView.image = successImage
            textField.rightView = validationImageView
            
        } else {
            currentMode = .failed
            textField.textColor = failureColor
            underlineView.backgroundColor  = failureColor
            
            validationLabel.text = message
            
            validationImageView.image = failureImage
            textField.rightView = validationImageView
        }
        
        return isValid
        
    }
    
    private func validate(enteredText: String, with rule: FormFieldValidationRule) -> Bool {
        switch rule {
            
        case .maxChar(let maxChar):
            let isValid = enteredText.count > 0 && enteredText.count <= maxChar
            return isValid
            
        case .asciiPrintableChars:
            let isValid = FormFieldValidationRule.asciiPrintableCharactersPredicate.evaluate(with: enteredText)
            return isValid
            
        case .minMaxChar(let minChar, let maxChar):
            let isValid = enteredText.count >= minChar && enteredText.count < maxChar
            return isValid
            
        case .invalidPasswordChars:
            let isValid = FormFieldValidationRule.validPasswordCharactersPredicate.evaluate(with: enteredText)
            return isValid
       
        case .emptyPhoneNumber:
            let isValid = enteredText.count > 0
            return isValid

        case .validPhoneNumber:
            let isValid = FormFieldValidationRule.phoneNumberPredicate.evaluate(with: enteredText)
            return isValid

        }
        
    }

}

extension FormField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.currentMode = .edit
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
