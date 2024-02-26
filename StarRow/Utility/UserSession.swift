//
//  UserSession.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 26/02/24.
//

import Foundation

class UserSession {
    
    static private let singleton = UserSession()
    
    static var shared: UserSession {
        return singleton
    }
    
    var token: String? {
        let userdefaults = UserDefaults.standard
        let token = userdefaults.value(forKey: "tokenSession")
        return token as? String
    }
    
    var email: String? {
        let userdefaults = UserDefaults.standard
        let email = userdefaults.value(forKey: "emailSession")
        return email as? String
    }
    
    private init() { }
    
    class func renewSessionWithToken(_ token: String, email: String) {
        //TODO: No debemos usar userdefaults para guardar data sensible
        let userdefaults = UserDefaults.standard
        userdefaults.set(token, forKey: "tokenSession")
        userdefaults.set(email, forKey: "emailSession")
        userdefaults.synchronize()
    }
}
