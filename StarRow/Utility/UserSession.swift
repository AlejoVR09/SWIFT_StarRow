//
//  UserSession.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 26/02/24.
//

import Foundation

class UserSession {
    
    static private(set) var singleton = UserSession()
    
    static var shared: UserSession {
        return singleton
    }
    
    private init() { }
    
    static func rememberCurrentProfile(remember: Bool){
        UserDefaults.standard.setValue(remember, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
    }
    
    static func getRememberedSession() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    static func currentSessionProfile(currentUserEmail: String){
        UserDefaults.standard.setValue(currentUserEmail, forKey: "emailLogged")
        UserDefaults.standard.synchronize()
    }
    
    static func getCurrentSessionProfile() -> String {
        return UserDefaults.standard.string(forKey: "emailLogged") ?? ""
    }
}
