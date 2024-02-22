//
//  LargeLoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import UIKit

class LargeLoginStrategy: LoginViewStrategy {
    func loadLoginView(_ loginView: LoginView) {
        loginView.setLargeLogin()
    }
}
