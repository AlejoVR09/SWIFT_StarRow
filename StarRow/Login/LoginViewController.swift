//
//  LoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit


class LoginViewController: UIViewController {
    private lazy var notificationCenter = NotificationManager(notificationManagerDelegate: self)
    private var loginView: LoginViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalTransitionStyle = .flipHorizontal
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginView = UserDefaults.standard.bool(forKey: "isLoggedIn") ? ShortLoginView(delegate: self) : FullLoginView(delegate: self)
        self.view = self.loginView as? UIView
        self.notificationCenter.registerObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.notificationCenter.removeObserver()
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ loginView: LoginViewProtocol, withValidEmail validEmail: Bool) {
        guard validEmail else {
            loginView.setEmailErrorText?(text: "invalidEmail".localized(withComment: "invalidEmailComment"))
            return
        }
//        UserSession.initSession(email: <#T##String#>, remember: <#T##Bool#>)
        self.navigationController?.show(TabBarController(), sender: nil)
    }
    
    func loginViewDidButtonPressedToSignUp(loginView: LoginViewProtocol) {
        self.navigationController?.show(RegisterViewController(registerView: RegisterView()), sender: nil)
    }
    
    func loginViewGoToLargeLogin() {
        self.loginView = FullLoginView(delegate: self)
        self.view = self.loginView as? UIView
    }
}

extension LoginViewController: NotificationManagerDelegate {
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillShow info: NotificationManager.Info) {
        self.loginView?.keyboardAppear?(info)
    }
    
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillHide info: NotificationManager.Info) {
        self.loginView?.keyboardDisappear?(info)
    }
}

extension LoginViewController {
    class func buildLogin() -> LoginViewController {
        let controller = LoginViewController()
        return controller
    }
}
