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
    
    override init(frame: CGRect) {
        bottomConstraint = signUpButton.topAnchor.constraint(equalTo: phoneStack.bottomAnchor, constant: 20)
        super.init(frame: .zero)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        addGestureRecognizer(tapGesture)
        backgroundColor = .black
        setConstraintsForRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let backGroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "RowStar_1"))
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
    
    private var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(named: "MainOpacity")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nameStack: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 0)
    
    private let emailStack: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 0)
    
    private let phoneStack: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 0)
    
    private let userNameLabel: UILabel = MainLabel(withText: "Name", color: "MainInverse", alignment: .left, size: 16)
    
    private let userEmailLabel: UILabel = MainLabel(withText: "Email", color: "MainInverse", alignment: .left, size: 16)
    
    private let userPhoneLabel: UILabel = MainLabel(withText: "Phone", color: "MainInverse", alignment: .left, size: 16)

    private let userNameTextField: UITextField = MainTextField(withText: "Name")
    
    private let userEmailTextField: UITextField = MainTextField(withText: "Email")
    
    private let userPhoneTextField: UITextField = MainTextField(withText: "Phone")
    
    private let signUpButton: UIButton = {
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
    
    private let separatorToLabel: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "MainInverse")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var tapGesture: UITapGestureRecognizer!
    
    private var bottomConstraint: NSLayoutConstraint
}

extension RegisterView {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @objc private func goToMoviesView(){
        self.delegate?.buttonPressedToSign(self)
    }
}

extension RegisterView {
    func keyBoardWillShow(_ info: NotificationManager.Info){
        if info.frame.origin.y < self.userPhoneTextField.frame.maxY {
            UIView.animate(withDuration: info.animation) {
                self.bottomConstraint.constant = self.userPhoneTextField.frame.maxY - info.frame.origin.y + self.bottomConstraint.constant + 20
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
        
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 400),
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50),
        ])
        
        contentView.addSubview(separatorToLabel)
        NSLayoutConstraint.activate([
            separatorToLabel.heightAnchor.constraint(equalToConstant: 1),
            separatorToLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            separatorToLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separatorToLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ])
        
        
        contentView.addSubview(nameStack)
        NSLayoutConstraint.activate([
            nameStack.topAnchor.constraint(equalTo: separatorToLabel.bottomAnchor, constant: 10),
            nameStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
        nameStack.addArrangedSubview(userNameLabel)
        nameStack.addArrangedSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentView.addSubview(emailStack)
        NSLayoutConstraint.activate([
            emailStack.topAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 10),
            emailStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            emailStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
        
        emailStack.addArrangedSubview(userEmailLabel)
        emailStack.addArrangedSubview(userEmailTextField)
        NSLayoutConstraint.activate([
            userEmailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentView.addSubview(phoneStack)
        NSLayoutConstraint.activate([
            phoneStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor, constant: 10),
            phoneStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            phoneStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        phoneStack.addArrangedSubview(userPhoneLabel)
        phoneStack.addArrangedSubview(userPhoneTextField)
        NSLayoutConstraint.activate([
            userPhoneTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentView.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            bottomConstraint,
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
}
