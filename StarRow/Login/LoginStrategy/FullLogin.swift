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
        view.layer.cornerRadius = 30
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
        label.font = UIFont(name: "Marker Felt", size: 30)
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
        label.font = UIFont(name: "Marker Felt", size: 36)
        label.textAlignment = .center
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userNameTextField: UITextField = MainTextField(withText: "Email")
    
    private let buttonForLoging: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.layer.borderColor = UIColor(named: "MainText")?.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .clear
        button.titleLabel?.tintColor = UIColor(named: "MainInverse")
        button.titleLabel?.font = UIFont(name: "Marker Felt", size: 24 )
        button.layer.cornerRadius = 15
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToMoviesView), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 10)
    
    private let innerStack: UIStackView = StackViewType(orientation: .horizontal, innerSpacing: 10)
    
    private let buttonForRegister: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.tintColor = UIColor(named: "MainInverse")
        button.titleLabel?.font = UIFont(name: "Marker Felt", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(named: "MainText")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.addTarget(nil, action: #selector(goToRegisterView), for: .touchUpInside)
        return button
    }()
    
    private let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.frame = .zero
        switcher.tintColor = UIColor(named: "Main")
        switcher.onTintColor = UIColor(named: "MainText")
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(nil, action: #selector(yes), for: .touchUpInside)
        return switcher
    }()
    
    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MainInverse")
        label.font = UIFont(name: "Marker Felt", size: 18)
        label.textAlignment = .center
        label.text = "Remember Me?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
            appNameView.heightAnchor.constraint(equalToConstant: 60),
            appNameView.topAnchor.constraint(equalTo: upperImage.bottomAnchor, constant: -25),
            appNameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            appNameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45)
        ])
        
        
        appNameView.addSubview(appNameLabel)
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: appNameView.centerXAnchor),
            appNameLabel.centerYAnchor.constraint(equalTo: appNameView.centerYAnchor)
        ])
        
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            contentView.topAnchor.constraint(equalTo: appNameView.bottomAnchor, constant: 20)
        ])
        
        contentView.addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginLabel.heightAnchor.constraint(equalToConstant: 50),
            loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            loginLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ])
        
        contentView.addSubview(separatorToLabel)
        NSLayoutConstraint.activate([
            separatorToLabel.heightAnchor.constraint(equalToConstant: 1),
            separatorToLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            separatorToLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separatorToLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 1)
        ])
        
        addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.heightAnchor.constraint(equalToConstant: 60),
            userNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            userNameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
        
        contentView.addSubview(buttonForLoging)
        NSLayoutConstraint.activate([
            bottomConstraint,
            buttonForLoging.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            buttonForLoging.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            buttonForLoging.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: buttonForLoging.bottomAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30)
        ])
        
        stackView.addArrangedSubview(innerStack)
        innerStack.addArrangedSubview(switcher)
        innerStack.addArrangedSubview(rememberMeLabel)
        stackView.addArrangedSubview(buttonForRegister)
        
    }
}


