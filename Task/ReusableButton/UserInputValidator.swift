//
//  UserInputValidator.swift
//  Telenet
//
//  Created by Benedict Cohen on 30/04/2018.
//  Copyright © 2018 Telenet. All rights reserved.
//

import Foundation


enum UserInputValidationError: Error {
    case cannotBeEmpty
    case invalidEmail
    case invalidPhoneNumber
}


protocol UserInputValidator { }


// MARK: - Validators

private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
private let phonePredicate = NSPredicate(format: "SELF MATCHES %@", "0[0-9]{8,10}") //This needs to support for both mobile and Telephone number


extension UserInputValidator {

    func isEmptyString(_ string: String?) -> Bool {
        guard let string = string else {
            return true
        }
        return string.isEmpty
    }

    func isValidEmail(_ email: String?) -> Bool {
        return emailPredicate.evaluate(with: email ?? "")
    }

    func isValidPhoneNumber(phoneNumber: String?) -> Bool {
        return phonePredicate.evaluate(with: phoneNumber ?? "")
    }
}
