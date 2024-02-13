//
//  LoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit


class LoginViewController: UIViewController {
    var userDefaults: UserDefaults!
    
    
    var loginView: LoginView? {
        self.view as? LoginView
    }
    
    lazy var notificationCenter = NotificationManager(notificationManagerDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.delegate = self
        //let navigation = UINavigationController(rootViewController: self)
        self.navigationItem.title = "Login"

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.notificationCenter.registerObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.notificationCenter.removeObserver()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: LoginViewDelegate {
    func loginView(_ loginView: LoginView, withEmail email: String) {
        guard
            let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieView") as? UITabBarController
        else {
            return
        }
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
        self.navigationController?.show(mainTabBarController, sender: nil)
    }
    
    func loginViewDidButtonPressedToSignUp(loginView: LoginView) {
        let registerController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterView")
        print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
        self.navigationController?.show(registerController, sender: nil)
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
