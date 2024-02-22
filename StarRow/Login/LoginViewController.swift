//
//  LoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit


class LoginViewController: UIViewController {
    var strategy: LoginViewStrategy
    var loginView: LoginView
    
    lazy var notificationCenter = NotificationManager(notificationManagerDelegate: self)
    
    init(strategy: LoginViewStrategy, loginView: LoginView) {
        self.strategy = strategy
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
        self.navigationItem.title = "Login"
        
        self.strategy.loadLoginView(loginView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.notificationCenter.registerObserver()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.notificationCenter.removeObserver()
    }
}

extension LoginViewController {
    static func buildLargeLogin() -> LoginViewController {
        let view = LoginView()
        let strategy = LargeLoginStrategy()
        let controller = LoginViewController(strategy: strategy, loginView: view)
        return controller
    }
    
    static func buildShortLogin() -> LoginViewController {
        let view = LoginView()
        let strategy = ShortLoginStrategy()
        let controller = LoginViewController(strategy: strategy, loginView: view)
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
