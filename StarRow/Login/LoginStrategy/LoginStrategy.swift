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
}

extension LoginViewProtocol {
    func keyboardAppear(_ info: NotificationManager.Info){}
    func keyboardDisappear(_ info: NotificationManager.Info){}
}

protocol LoginViewDelegate {
    func loginView(_ loginView: LoginViewProtocol, withEmail email: String)
    func loginViewDidButtonPressedToSignUp(loginView: LoginViewProtocol)
    func loginViewGoToLargeLogin()
}

extension LoginViewDelegate {
    func loginView(_ loginView: LoginViewProtocol, withEmail email: String){}
    func loginViewGoToLargeLogin(){}
}
