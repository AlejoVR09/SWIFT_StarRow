//
//  LoginView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

protocol LoginViewDelegate {
    func didButtonPressedToLoginWithEmail(loginView: LoginView)
    func didButtonPressedToSign(loginView: LoginView)
}

class LoginView: UIView {
    var delegate: LoginViewDelegate?
    
    @IBOutlet private weak var userNameTextField: UITextField!
    
    func newImageIcon(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40));
        let image = UIImage(named: "goku");
        imageView.image = image;
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        userNameTextField.leftViewMode = UITextField.ViewMode.always
        userNameTextField.leftView = view;
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func login(_ sender: UIButton) {
        delegate?.didButtonPressedToLoginWithEmail(loginView: self)
    }
    @IBAction func signUp(_ sender: UIButton) {
        delegate?.didButtonPressedToSign(loginView: self)
    }
}
