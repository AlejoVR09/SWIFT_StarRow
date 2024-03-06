//
//  LargeLoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import UIKit

class FullLoginView: UIView, LoginViewProtocol {
    private var delegate: LoginViewDelegate
    
    init(delegate: LoginViewDelegate){
        bottomConstraint = buttonForLoging.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20)
        self.delegate = delegate
        super.init(frame: .zero)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        addGestureRecognizer(tapGesture)
        backgroundColor = UIColor(named: "Main")
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let upperImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "UpperImage"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let appNameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 50
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Impact", size: 24)
        label.textAlignment = .center
        label.text = "StarRow"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "MainOpacityInverse")
        view.layer.cornerRadius = 15
        return view
    }()
    
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
        button.backgroundColor = .clear
        button.titleLabel?.tintColor = UIColor(named: "MainInverse")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToMoviesView), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let buttonForRegister: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.tintColor = UIColor(named: "MainInverse")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToRegisterView), for: .touchUpInside)
        return button
    }()
    
    private let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.frame = .zero
        switcher.tintColor = UIColor(named: "Main")
        switcher.thumbTintColor = UIColor(named: "MainInverse")
        switcher.onTintColor = UIColor(named: "MainText")
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(nil, action: #selector(yes), for: .touchUpInside)
        return switcher
    }()
    
    private let separator: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "MainInverse")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorToLabel: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "MainInverse")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var tapGesture: UITapGestureRecognizer!
    
    private var bottomConstraint: NSLayoutConstraint
}

extension FullLoginView {
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

extension FullLoginView {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }

    @objc private func goToRegisterView(){
        self.delegate.loginViewDidButtonPressedToSignUp(loginView: self)
    }
    
    @objc private func goToMoviesView(){
        self.delegate.loginView(self, withEmail: self.userNameTextField.text ?? "")
    }
     
    @objc private func yes(){
    }
}

extension FullLoginView {
    private func setConstraints(){
        addSubview(upperImage)
        NSLayoutConstraint.activate([
            upperImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            upperImage.topAnchor.constraint(equalTo: topAnchor),
            upperImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            upperImage.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        addSubview(appNameView)
        NSLayoutConstraint.activate([
            appNameView.heightAnchor.constraint(equalToConstant: 100),
            appNameView.topAnchor.constraint(equalTo: upperImage.bottomAnchor, constant: -25),
            appNameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            appNameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25)
        ])
        
        
        appNameView.addSubview(appNameLabel)
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: appNameView.centerXAnchor),
            appNameLabel.centerYAnchor.constraint(equalTo: appNameView.centerYAnchor)
        ])
        
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            contentView.topAnchor.constraint(equalTo: appNameView.bottomAnchor, constant: 20)
        ])
        
        contentView.addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginLabel.heightAnchor.constraint(equalToConstant: 50),
            loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            loginLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        contentView.addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            userNameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
        
        contentView.addSubview(buttonForLoging)
        NSLayoutConstraint.activate([
            bottomConstraint,
            buttonForLoging.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            buttonForLoging.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40)
        ])
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: buttonForLoging.bottomAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40)
        ])
        
        stackView.addArrangedSubview(switcher)
        stackView.addArrangedSubview(buttonForRegister)
        
        
        
    }
}


