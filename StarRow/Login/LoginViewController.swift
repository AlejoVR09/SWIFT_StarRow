//
//  LoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit


class LoginViewController: UIViewController {
    var strategy: LoginViewStrategy?
    var loginView: LoginView
    lazy var notificationCenter = NotificationManager(notificationManagerDelegate: self)
    
    init(loginView: LoginView) {
        self.loginView = loginView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
        self.view = loginView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.notificationCenter.registerObserver()
        self.strategy = UserDefaults.standard.bool(forKey: "isLoggedIn") ? ShortLoginStrategy() : LargeLoginStrategy()
        self.strategy?.loadLoginView(self.loginView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.notificationCenter.removeObserver()
        self.strategy?.removeView?(self.loginView)
    }
}

extension LoginViewController {
    class func buildLargeLogin() -> LoginViewController {
        let view = LoginView()
        let controller = LoginViewController(loginView: view)
        return controller
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ loginView: LoginView, withEmail email: String) {
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
        self.navigationController?.show(TabBarController(), sender: nil)
    }
    
    func loginViewDidButtonPressedToSignUp(loginView: LoginView) {
        self.navigationController?.show(RegisterViewController(registerView: RegisterView()), sender: nil)
    }
}

extension LoginViewController: NotificationManagerDelegate {
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillShow info: NotificationManager.Info) {
        self.loginView.keyboardAppear(info)
    }
    
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillHide info: NotificationManager.Info) {
        self.loginView.keyboardDisappear(info)
    }
}
