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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backToLogin))
    }
}

extension RegisterViewController {
    @objc func backToLogin(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func buttonPressedToSign(_ registerView: RegisterView, withName: String, email: String, andPhone: String) {
        do {
            try {
                try userDataValidation.validateName(name: withName)
                try userDataValidation.validateEmail(email: email)
                try userDataValidation.validatePhone(phone: andPhone)
            }()
            self.navigationController?.show(TabBarController(), sender: nil)
        } catch let errors {
            print("Se han producido los siguientes errores: \(errors)")
        }

    }
    
    func buttonPressedToSign(_ registerView: RegisterView) {
        
    }
}
