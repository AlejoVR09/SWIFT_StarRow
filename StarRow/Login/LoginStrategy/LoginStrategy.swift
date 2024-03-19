//
//  LoginStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import Foundation

@objc protocol LoginViewProtocol {
    @objc optional func keyboardAppear(_ info: Any)
    @objc optional func keyboardDisappear(_ info: Any)
    @objc optional func setEmailErrorText(text: String)
}

@objc protocol LoginViewDelegate {
    @objc optional func loginView(_ loginView: LoginViewProtocol, withValidEmail validEmail: Bool)
    func loginViewDidButtonPressedToSignUp(loginView: LoginViewProtocol)
    @objc optional func loginViewGoToLargeLogin()
}  
