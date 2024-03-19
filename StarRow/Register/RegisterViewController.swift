//
//  RegisterViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class RegisterViewController: UIViewController {

    private let userDataValidation = UserDataValidation()
    private var registerView: RegisterView
    
    init(registerView: RegisterView) {
        self.registerView = registerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = registerView
        self.registerView.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BackButtonText".localized(withComment: "BackButtonTextComment".localized()), style: .plain, target: self, action: #selector(backToLogin))
    }
}

extension RegisterViewController {
    @objc func backToLogin(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func buttonPressedToSign(_ registerView: RegisterView, validName: Bool, validEmail: Bool, validPhone: Bool) {
        if validName && validEmail && validPhone {
            self.navigationController?.show(TabBarController(), sender: nil)

        }
        else {
            if !validName {
                registerView.setNameErrorText(text: "invalidName".localized(withComment: "invalidNameComment".localized()))
            }
            if !validEmail {
                registerView.setEmailErrorText(text: "invalidEmail".localized(withComment: "invalidEmailComment".localized()))
            }
            if !validPhone {
                registerView.setPhoneErrorText(text: "invalidPhone".localized(withComment: "invalidPhoneComment".localized()))
            }
        }
    }
}
