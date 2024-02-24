//
//  LoginStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import Foundation

@objc protocol LoginViewStrategy: AnyObject {
    func loadLoginView(_ loginView: LoginView)
    @objc optional func removeView(_ loginView: LoginView)
}
