//
//  LoginStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import Foundation

// MARK: Strategy Protocol
@objc protocol LoginViewProtocol {
    @objc optional func keyboardAppear(_ info: Any)
    @objc optional func keyboardDisappear(_ info: Any)
    @objc optional func setEmailErrorText(text: String)
    @objc optional func setLogingButtonText(message: String)

}

// MARK: Strategy Delegate
@objc protocol LoginViewDelegate {
    @objc optional func loginView(_ loginView: LoginViewProtocol, withEmail: String, validEmail: Bool, remember: Bool)
    func loginViewDidButtonPressedToSignUp(loginView: LoginViewProtocol)
    @objc optional func loginViewGoToLargeLogin()
    @objc optional func loginViewWithSwitcher(isOn: Bool)
}
