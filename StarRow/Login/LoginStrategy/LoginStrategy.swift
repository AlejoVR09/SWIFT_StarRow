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

@objc protocol LoginViewStrategy: AnyObject {
    func setConstraints(_ loginView: LoginView)
    @objc optional func removeView(_ loginView: LoginView)
}
