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
    
    private init() { }
    
    static func initSession(email: String, remember: Bool){
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
        UserDefaults.standard.setValue(email, forKey: "emailLogged")
        UserDefaults.standard.synchronize()
    }
    
}
