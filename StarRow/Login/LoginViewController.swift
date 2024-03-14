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
    private lazy var userDataValidation = UserDataValidation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do{
            try print(userDataValidation.validateEmail(email: "Alejandro@.co"))
        }
        catch{
            print(error)
        }
        
        self.loginView = UserDefaults.standard.bool(forKey: "isLoggedIn") ? ShortLoginView(delegate: self) : FullLoginView(delegate: self)
        self.view = self.loginView as? UIView
        self.notificationCenter.registerObserver()
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        }
        else{
            print("Portraint")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.notificationCenter.removeObserver()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        }
        else{
            print("Portraint")
        }
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ loginView: LoginViewProtocol, withEmail email: String) {
        do{
            try userDataValidation.validateEmail(email: email)
            UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
            self.navigationController?.show(TabBarController(), sender: nil)
        }
        catch{
            print(error)
        }
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
