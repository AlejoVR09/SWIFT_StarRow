//
//  ShortLoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import UIKit

class ShortLoginStrategy: LoginViewStrategy{
    func removeView(_ loginView: LoginView) {
        loginView.removeLoginView()
    }
    
    func loadLoginView(_ loginView: LoginView) {
        loginView.setShortLogin()
    }
}
