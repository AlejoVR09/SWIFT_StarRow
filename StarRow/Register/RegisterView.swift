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
    
    private let backGroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "RowStar_2"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var visualEffect: UIVisualEffectView = {
        let visualEffect = UIVisualEffectView()
        visualEffect.effect = UIBlurEffect(style: .dark)
        visualEffect.layer.opacity = 0.5
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        return visualEffect
    }()
    
    private var view: UIView = {
        let view = UIView()
        view.layer.opacity = 0.5
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .init(red: 0.816, green: 0.851, blue: 0.910, alpha: 1)
        textField.placeholder = "User Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let userEmailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .init(red: 0.816, green: 0.851, blue: 0.910, alpha: 1)
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let userPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .init(red: 0.816, green: 0.851, blue: 0.910, alpha: 1)
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let signUpButton: UIButton = {
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
    
    private var tapGesture: UITapGestureRecognizer!
    
    private var bottomConstraint: NSLayoutConstraint
    
    override init(frame: CGRect) {
        bottomConstraint = NSLayoutConstraint(
            item: signUpButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: userNameTextField,
            attribute: .bottom,
            multiplier: 1,
            constant: 20)
        super.init(frame: .zero)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        addGestureRecognizer(tapGesture)
        backgroundColor = .black
        setConstraintsForRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @objc private func goToMoviesView(){
        self.delegate?.buttonPressedToSign(self)
    }
}

extension RegisterView {
    func keyBoardWillShow(_ info: NotificationManager.Info){
        if info.frame.origin.y < self.userNameTextField.frame.maxY {
            UIView.animate(withDuration: info.animation) {
                self.bottomConstraint.constant = self.userNameTextField.frame.maxY - info.frame.origin.y + self.bottomConstraint.constant + 20
                self.layoutIfNeeded()
            }
        }
    }
    
    func keyBoardWillHide(_ info: NotificationManager.Info){
        UIView.animate(withDuration: info.animation) {
            self.bottomConstraint.constant = 20
            self.layoutIfNeeded()
        }
    }
}

extension RegisterView {
    private func setConstraintsForRegister(){
        addSubview(backGroundImage)
        NSLayoutConstraint.activate([
            backGroundImage.topAnchor.constraint(equalTo: topAnchor),
            backGroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backGroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backGroundImage.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        backGroundImage.addSubview(visualEffect)
        NSLayoutConstraint.activate([
            visualEffect.topAnchor.constraint(equalTo: backGroundImage.topAnchor),
            visualEffect.bottomAnchor.constraint(equalTo: backGroundImage.bottomAnchor),
            visualEffect.trailingAnchor.constraint(equalTo: backGroundImage.trailingAnchor),
            visualEffect.leadingAnchor.constraint(equalTo: backGroundImage.leadingAnchor)
        ])
        
        addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            userNameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
        
        addSubview(signUpButton)
        NSLayoutConstraint.activate([
            bottomConstraint,
            signUpButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signUpButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            signUpButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
    }
}
