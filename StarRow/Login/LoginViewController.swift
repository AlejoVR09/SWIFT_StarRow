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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalTransitionStyle = .flipHorizontal
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginView = UserSession.getRememberedSession() ? ShortLoginView(delegate: self) : FullLoginView(delegate: self)
        self.loginView?.setLogingButtonText?(message: retrieveUser(email: UserSession.getCurrentSessionProfile())?.email ?? "")
        self.view = self.loginView as? UIView
        self.notificationCenter.registerObserver()
        //removeUser()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.notificationCenter.removeObserver()
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ loginView: LoginViewProtocol, withEmail: String, validEmail: Bool, remember: Bool) {
        guard validEmail else {
            loginView.setEmailErrorText?(text: "invalidEmail".localized(withComment: "invalidEmailComment"))
            return
        }
        guard !verifyExistingUser(email: withEmail) else {
            loginView.setEmailErrorText?(text: "notExistingEmail".localized(withComment: "notExistingEmailComment".localized()))
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
        print(isOn)
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
    func removeUser(){
        let moviesSaved = self.retrieveData()
        let result = moviesSaved.first { $0.name == "Alejo" }
        guard let result = result else { return }
        self.context.delete(result)
        do {
            try self.context.save()
        }
        catch{
            print(error)
        }
    }
    
    func retrieveUser(email: String) -> AppUser? {
        let moviesSaved = self.retrieveData()
        let result = moviesSaved.first { $0.email == email }
        guard let result = result else { return nil }
        return result
    }
    
    private func retrieveData() -> [AppUser]{
        do{
            let movies = try self.context.fetch(AppUser.fetchRequest())
            return movies
        }
        catch {
            return []
        }
    }
    
    func verifyExistingUser(email: String) -> Bool {
        let usersInApp = self.retrieveData()
        let result = usersInApp.first { $0.email == email }
        guard result != nil else { return true }
        return false
    }
}

extension LoginViewController {
    class func buildLogin() -> LoginViewController {
        let controller = LoginViewController()
        return controller
    }
}
