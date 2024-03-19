//
//  UserDataExceptions.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 14/03/24.
//

import Foundation

class UserDataValidation {
    class func validateName(name: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: AppConstant.RegexValidation.nameValidation)
        let range = NSRange(location: 0, length: name.utf16.count)
        guard regex.firstMatch(in: name, options: [], range: range) != nil else { 
            return false
        }
        return true
    }
    
    class func validateEmail(email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: AppConstant.RegexValidation.emailValidation)
        let range = NSRange(location: 0, length: email.utf16.count)
        guard regex.firstMatch(in: email, options: [], range: range) != nil else {
            return false
        }
        return true
    }
    
    class func validatePhone(phone: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: AppConstant.RegexValidation.phoneValidation)
        let range = NSRange(location: 0, length: phone.utf16.count)
        guard regex.firstMatch(in: phone, options: [], range: range) != nil else {
            return false
        }
        return true
    }
}
