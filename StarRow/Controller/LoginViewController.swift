//
//  LoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class LoginViewController: UIViewController {
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
        
        /*guard
            let a = self.navigationController?.viewControllers
        else{
            return
        }
        for i in a {
            print(i)
        }
         */
        // Do any additional setup after loading the view.
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
        self.navigationController?.show(registerController, sender: nil)
    }
    
    func didButtonPressedToLoginWithEmail(loginView: LoginView) {
        self.navigationController?.show(mainTabBarController!, sender: nil)
    }
    
    
}
