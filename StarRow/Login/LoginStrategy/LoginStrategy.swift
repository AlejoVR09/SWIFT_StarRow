//
//  LoginStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import Foundation

protocol LoginViewProtocol {
    func keyboardAppear(_ info: NotificationManager.Info)
    func keyboardDisappear(_ info: NotificationManager.Info)
    func setEmailErrorText(text: String)
}

extension LoginViewProtocol {
    func keyboardAppear(_ info: NotificationManager.Info){}
    func keyboardDisappear(_ info: NotificationManager.Info){}
    func setEmailErrorText(text: String){}
}

protocol LoginViewDelegate {
    func loginView(_ loginView: LoginViewProtocol, withValidEmail validEmail: Bool)
    func loginViewDidButtonPressedToSignUp(loginView: LoginViewProtocol)
    func loginViewGoToLargeLogin()
}

extension LoginViewDelegate {
    func loginView(_ loginView: LoginViewProtocol, withValidEmail validEmail: Bool){}
    func loginViewGoToLargeLogin(){}
}
