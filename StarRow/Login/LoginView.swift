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
    
    private let backGroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "RowStar_1"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .init(red: 0.816, green: 0.851, blue: 0.910, alpha: 1)
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let buttonForLoging: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.backgroundColor = .init(red: 0.144, green: 0.240, blue: 0.628, alpha: 1)
        button.titleLabel?.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToMoviesView), for: .touchUpInside)
        return button
    }()
    
    private let buttonForRegister: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Don't have an account? Sign up", for: .normal)
        button.titleLabel?.tintColor = .init(red: 1, green: 0.459, blue: 0.004, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToRegisterView), for: .touchUpInside)
        return button
    }()
    
    private var tapGesture: UITapGestureRecognizer!
    
    private var bottomConstraint: NSLayoutConstraint
    
    override init(frame: CGRect) {
        bottomConstraint = NSLayoutConstraint(
            item: buttonForLoging,
            attribute: .top,
            relatedBy: .equal,
            toItem: userNameTextField,
            attribute: .bottom,
            multiplier: 1,
            constant: 20)
        super.init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        addGestureRecognizer(tapGesture)
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }

    @objc private func goToRegisterView(){
        self.delegate?.loginViewDidButtonPressedToSignUp(loginView: self)
    }
    
    @objc private func goToMoviesView(){
        self.delegate?.loginView(self, withEmail: self.userNameTextField.text ?? "")
    }
}

extension LoginView {
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
}

extension LoginView{
    private func setConstraintsForShortLogin(){
        addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            userNameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
        
        addSubview(buttonForLoging)
        NSLayoutConstraint.activate([
            bottomConstraint,
            buttonForLoging.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            buttonForLoging.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
        
        addSubview(buttonForRegister)
        NSLayoutConstraint.activate([
            buttonForRegister.topAnchor.constraint(equalTo: buttonForLoging.bottomAnchor, constant: 20),
            buttonForRegister.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonForRegister.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            buttonForRegister.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
    }
    
    private func setConstraintsForLargeLogin(){
        addSubview(backGroundImage)
        NSLayoutConstraint.activate([
            backGroundImage.topAnchor.constraint(equalTo: topAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backGroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backGroundImage.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            userNameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
        
        addSubview(buttonForLoging)
        NSLayoutConstraint.activate([
            bottomConstraint,
            buttonForLoging.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            buttonForLoging.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
        
        addSubview(buttonForRegister)
        NSLayoutConstraint.activate([
            buttonForRegister.topAnchor.constraint(equalTo: buttonForLoging.bottomAnchor, constant: 20),
            buttonForRegister.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonForRegister.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            buttonForRegister.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
    }
    
    func removeLoginView(){
        userNameTextField.removeFromSuperview()
        
        buttonForLoging.removeFromSuperview()
        
        buttonForRegister.removeFromSuperview()
    }
    
    func setShortLogin(){
        setConstraintsForShortLogin()
    }
    
    func setLargeLogin(){
        setConstraintsForLargeLogin()
    }

}

