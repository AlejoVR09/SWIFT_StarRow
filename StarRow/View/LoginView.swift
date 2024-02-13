//
//  LoginView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

protocol LoginViewDelegate {
    func loginView(_ loginView: LoginView, withEmail email: String)
    func loginViewDidButtonPressedToSignUp(loginView: LoginView)
}

class LoginView: UIView {
    var delegate: LoginViewDelegate?
    
    @IBOutlet private weak var userNameTextField: UITextField!
    
    @IBOutlet weak var buttonForLoging: UIButton!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func keyboardAppear(_ info: NotificationManager.Info){
        if info.frame.origin.y < self.userNameTextField.frame.maxY {
            UIView.animate(withDuration: info.animation) {
                self.bottomConstraint.constant = self.userNameTextField.frame.maxY - info.frame.origin.y + self.bottomConstraint.constant + 20
                self.layoutIfNeeded()
            }
        }
    }
    
    func keyboardDisappear(_ info: NotificationManager.Info){
        UIView.animate(withDuration: info.animation) {
            self.bottomConstraint.constant = 20
            self.layoutIfNeeded()
        }
    }

    @IBAction func login(_ sender: UIButton) {
        delegate?.loginView(self, withEmail: userNameTextField.text ?? "")
    }
    @IBAction func signUp(_ sender: UIButton) {
        delegate?.loginViewDidButtonPressedToSignUp(loginView: self)
    }
    
    @IBAction func tapToCloseKeyBoard(_ sender: Any) {
        self.endEditing(true)
    }
}
