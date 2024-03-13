//
//  RegisterViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerView: RegisterView
    
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(signOut))
    }
}

extension RegisterViewController {
    @objc func signOut(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func buttonPressedToSign(_ registerView: RegisterView) {
        self.navigationController?.show(TabBarController(), sender: nil)
    }
}
