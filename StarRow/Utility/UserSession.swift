//
//  UserSession.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 26/02/24.
//

import Foundation

// MARK: Class declaration
class UserSession {
    static private(set) var singleton = UserSession()
    
    static var shared: UserSession {
        return singleton
    }
    
    private init() { }
    
    static func rememberCurrentProfile(remember: Bool){
        UserDefaults.standard.setValue(remember, forKey: AppConstant.UserDefaultsKeys.isLoggedIn)
        UserDefaults.standard.synchronize()
    }
    
    static func getRememberedSession() -> Bool {
        return UserDefaults.standard.bool(forKey: AppConstant.UserDefaultsKeys.isLoggedIn)
    }
    
    static func currentSessionProfile(currentUserEmail: String){
        UserDefaults.standard.setValue(currentUserEmail, forKey: AppConstant.UserDefaultsKeys.emailLogged)
        UserDefaults.standard.synchronize()
    }
    
    static func getCurrentSessionProfile() -> String {
        return UserDefaults.standard.string(forKey: AppConstant.UserDefaultsKeys.emailLogged) ?? ""
    }
}
