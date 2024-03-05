//
//  ShortLoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import UIKit

class ShortLoginView: UIView {
    var delegate: LoginViewDelegate
    
    init(delegate: LoginViewDelegate) {
        bottomConstraint = NSLayoutConstraint(
            item: buttonForLoging,
            attribute: .top,
            relatedBy: .equal,
            toItem: userNameTextField,
            attribute: .bottom,
            multiplier: 1,
            constant: 20)
        self.delegate = delegate
        super.init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        addGestureRecognizer(tapGesture)
        backgroundColor = UIColor(named: "Main")
        setLogin()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MainInverse")
        label.font = UIFont(name: "Impact", size: 36)
        label.textAlignment = .center
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .init(white: 0, alpha: 0)
        textField.placeholder = "Email"
        textField.textColor = UIColor(named: "MainInverse")
        textField.layer.borderColor = UIColor(named: "MainText")?.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let buttonForLoging: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.layer.borderColor = UIColor(named: "MainText")?.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(named: "Main")
        button.titleLabel?.tintColor = UIColor(named: "MainInverse")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToMoviesView), for: .touchUpInside)
        return button
    }()
    
    private let buttonForRegister: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.setTitle("Don't have an account? Sign up", for: .normal)
        button.titleLabel?.tintColor = UIColor(named: "MainInverse")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToRegisterView), for: .touchUpInside)
        return button
    }()
    
    private var tapGesture: UITapGestureRecognizer!
    
    private var bottomConstraint: NSLayoutConstraint
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }

    @objc private func goToRegisterView(){
        self.delegate.loginViewDidButtonPressedToSignUp(loginView: self)
    }
    
    @objc private func goToMoviesView(){
        self.delegate.loginView(self, withEmail: self.userNameTextField.text ?? "")
    }
}

extension ShortLoginView {
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

extension ShortLoginView: LoginViewProtocol {
    func setConstraints(){
        addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginLabel.heightAnchor.constraint(equalToConstant: 50),
            loginLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            loginLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50),
        ])
        
        addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 50),
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
    
    func setLogin(){
        setConstraints()
    }
}
