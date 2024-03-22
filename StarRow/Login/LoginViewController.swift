//
//  LoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

// MARK: Class declaration
class LoginViewController: UIViewController {
    private lazy var notificationCenter = NotificationManager(notificationManagerDelegate: self)
    private var loginView: LoginViewProtocol?
    private let userProvider = AppUserCoreDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginView = UserSession.getRememberedSession() ? ShortLoginView(delegate: self) : FullLoginView(delegate: self)
        self.loginView?.setLogingButtonText?(message: userProvider.retrieveUser(email: UserSession.getCurrentSessionProfile())?.email ?? "")
        self.view = self.loginView as? UIView
        self.notificationCenter.registerObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.notificationCenter.removeObserver()
    }
}

// MARK: View Delegates
extension LoginViewController: LoginViewDelegate {
    func loginView(_ loginView: LoginViewProtocol, withEmail: String, validEmail: Bool, remember: Bool) {
        guard validEmail else {
            loginView.setEmailErrorText?(text: AppConstant.Translations.invalidEmailText)
            return
        }
        guard !userProvider.verifyExistingUser(email: withEmail) else {
            loginView.setEmailErrorText?(text: AppConstant.Translations.notExistingEmailText)
            return
        }
        UserSession.currentSessionProfile(currentUserEmail: withEmail)
        UserSession.rememberCurrentProfile(remember: remember)
        self.navigationController?.show(TabBarController(), sender: nil)
    }
    
    func loginViewDidButtonPressedToSignUp(loginView: LoginViewProtocol) {
        self.navigationController?.show(RegisterViewController(registerView: RegisterView()), sender: nil)
    }
    
    func loginViewGoToLargeLogin() {
        self.loginView = FullLoginView(delegate: self)
        self.view = self.loginView as? UIView
    }
    
    func loginViewWithSwitcher(isOn: Bool) {
        UserSession.rememberCurrentProfile(remember: isOn)
    }
}

// MARK: Notification Manager Delegate
extension LoginViewController: NotificationManagerDelegate {
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillShow info: NotificationManager.Info) {
        self.loginView?.keyboardAppear?(info)
    }
    
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillHide info: NotificationManager.Info) {
        self.loginView?.keyboardDisappear?(info)
    }
}

// MARK: LoginViewController Builder
extension LoginViewController {
    class func buildLogin() -> LoginViewController {
        let controller = LoginViewController()
        return controller
    }
}
