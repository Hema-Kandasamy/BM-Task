//
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//
//

import Foundation


//Add any rules as per requirement

enum FormFieldValidationRule {
    case maxChar(Int)
    case minMaxChar(Int, Int)
    case asciiPrintableChars
    case invalidPasswordChars
    
    case emptyPhoneNumber
    case validPhoneNumber
}

extension FormFieldValidationRule {
    
    // [ -~] is the range of printable ASCII characters (space to tilder)
    static let asciiPrintableCharactersPredicate = NSPredicate(format: "SELF MATCHES %@", "[ -~]*")
    
    // [^\x21-\x7E] supplied by telenet
    static let validPasswordCharactersPredicate = NSPredicate(format: "SELF MATCHES %@", "[\\x21-\\x7E]*")
    
    static let phoneNumberPredicate =  NSPredicate(format: "SELF MATCHES %@", "^((\\+[0-9]{1,3})|0)[0-9]{10}$")
    
    
    var message: String {
        switch self {
        case .maxChar:
            return "Your value must contain between 1 and 32 characters (including spaces)."
            
        case .asciiPrintableChars:
            return "Can not contain non-ASCII characters"
            
        case .minMaxChar:
            return "Password must contain at least 8 characters."
            
        case .invalidPasswordChars:
            return "Contains invalid characters"
            
        case .emptyPhoneNumber:
            return "Please enter your phone number"
            
        case.validPhoneNumber:
            return "This telephone number doesn't look right. Will you check again?"
        
        }
    }
    
}
