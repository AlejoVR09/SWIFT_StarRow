//
//  UserDataExceptions.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 14/03/24.
//

import Foundation

enum UserDataException: Error {
    case userInvalid(message: String)
    case emailInvalid(message: String)
    case phoneInvalid(message: String)
}

class UserDataValidation {
    func validateName(name: String) throws {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z]+$")
        let range = NSRange(location: 0, length: name.utf16.count)
        guard regex.firstMatch(in: name, options: [], range: range) != nil else { 
            throw UserDataException.userInvalid(message: "Wrong name")
        }
    }
    
    func validateEmail(email: String) throws {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")
        let range = NSRange(location: 0, length: email.utf16.count)
        guard regex.firstMatch(in: email, options: [], range: range) != nil else {
            throw UserDataException.emailInvalid(message: "Wrong email")
        }
    }
    
    func validatePhone(phone: String) throws {
        let regex = try! NSRegularExpression(pattern: #"^\d{10}$"#)
        let range = NSRange(location: 0, length: phone.utf16.count)
        guard regex.firstMatch(in: phone, options: [], range: range) != nil else {
            throw UserDataException.phoneInvalid(message: "Wrong phone")
        }
    }
}
