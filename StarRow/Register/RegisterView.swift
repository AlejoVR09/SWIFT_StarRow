//
//  RegisterView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

protocol RegisterViewDelegate {
    func buttonPressedToSign(_ registerView: RegisterView)
}

class RegisterView: UIView {
    
    var delegate: RegisterViewDelegate?

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    
    @IBAction func buttonPressedToSignUp(_ sender: Any) {
        self.delegate?.buttonPressedToSign(self)
    }
    
    @IBAction func tapToCloseKeyBoard(_ sender: Any) {
        self.endEditing(true)
    }
    
    func keyBoardWillShow(_ info: NotificationManager.Info){
        if info.frame.origin.y < self.userNameTextField.frame.maxY {
            UIView.animate(withDuration: info.animation) {
                self.bottomContraint.constant = self.userNameTextField.frame.maxY - info.frame.origin.y + self.bottomContraint.constant + 20
                self.layoutIfNeeded()
            }
        }
    }
    
    func keyBoardWillHide(_ info: NotificationManager.Info){
        UIView.animate(withDuration: info.animation) {
            self.bottomContraint.constant = 20
            self.layoutIfNeeded()
        }
    }
}
