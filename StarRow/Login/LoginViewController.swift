//
//  LoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit


class LoginViewController: UIViewController {
    lazy var notificationCenter = NotificationManager(notificationManagerDelegate: self)
    private var loginView: LoginViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.notificationCenter.registerObserver()
        self.view = UserDefaults.standard.bool(forKey: "isLoggedIn") ? ShortLoginView(delegate: self) : FullLoginView(delegate: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.notificationCenter.removeObserver()
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ loginView: LoginViewProtocol, withEmail email: String) {
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
        self.navigationController?.show(TabBarController(), sender: nil)
    }
    
    func loginViewDidButtonPressedToSignUp(loginView: LoginViewProtocol) {
        self.navigationController?.show(RegisterViewController(registerView: RegisterView()), sender: nil)
    }
}

extension LoginViewController: NotificationManagerDelegate {
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillShow info: NotificationManager.Info) {
        self.loginView?.keyboardAppear(info)
    }
    
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillHide info: NotificationManager.Info) {
        self.loginView?.keyboardDisappear(info)
    }
}

extension LoginViewController {
    class func buildLogin() -> LoginViewController {
        let controller = LoginViewController()
        return controller
    }
}
