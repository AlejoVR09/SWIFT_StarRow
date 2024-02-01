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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView?.delegate = self
        //let navigation = UINavigationController(rootViewController: self)

        
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
