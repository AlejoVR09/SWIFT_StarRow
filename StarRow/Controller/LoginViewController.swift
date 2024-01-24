//
//  LoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class LoginViewController: UIViewController {
    var userDefaults: UserDefaults!

    let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieView") as? UITabBarController
    
    //let movieController = MoviesViewController()
    
    let registerController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterView")
    
    //let registerController = RegisterViewController()
    
    var loginView: LoginView? {
        self.view as? LoginView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginView?.delegate = self
        loginView?.newImageIcon()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            print("Is")
        } else {
            print("no")
        }
        
            
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
    func didButtonPressedToSign(loginView: LoginView) {
        
        print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
        self.navigationController?.show(registerController, sender: nil)
    }
    
    func didButtonPressedToLoginWithEmail(loginView: LoginView) {
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
        self.navigationController?.show(mainTabBarController!, sender: nil)
    }
    
    
}
