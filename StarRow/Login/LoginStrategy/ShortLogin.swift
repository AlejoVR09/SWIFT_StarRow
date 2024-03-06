//
//  ShortLoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import UIKit
import SwiftUI

class ShortLoginView: UIView, LoginViewProtocol {
    var delegate: LoginViewDelegate
    
    init(delegate: LoginViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "Main")
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
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
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "MainOpacity")
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
    
    private let buttonForLoging: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.layer.borderColor = UIColor(named: "MainText")?.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor(named: "MainOpacity")
        button.setTitle("Login", for: .normal)
        button.titleLabel?.tintColor = UIColor(named: "MainInverse")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToMoviesView), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let buttonForSingUp: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.layer.borderColor = UIColor(named: "MainText")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.tintColor = UIColor(named: "MainInverse")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToRegisterView), for: .touchUpInside)
        return button
    }()
    
    private let buttonForLargeLogin: UIButton = {
        let button = UIButton(type: .system)
        button.frame = .zero
        button.layer.borderColor = UIColor(named: "MainText")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.setTitle("Use another account", for: .normal)
        button.titleLabel?.tintColor = UIColor(named: "MainInverse")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToLargeLogin), for: .touchUpInside)
        return button
    }()
    
    private let separatorToLabel: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "MainInverse")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorToButton: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "MainInverse")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}

extension ShortLoginView {
    @objc private func goToRegisterView(){
        self.delegate.loginViewDidButtonPressedToSignUp(loginView: self)
    }
    
    @objc private func goToMoviesView(){
        self.delegate.loginView(self, withEmail: "")
    }
    
    @objc private func goToLargeLogin(){
        self.delegate.loginViewGoToLargeLogin()
    }
}

extension ShortLoginView {
    func setConstraints(){
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
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            contentView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            contentView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
        
        contentView.addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginLabel.heightAnchor.constraint(equalToConstant: 50),
            loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
        ])
        
        contentView.addSubview(separatorToLabel)
        NSLayoutConstraint.activate([
            separatorToLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 25),
            separatorToLabel.heightAnchor.constraint(equalToConstant: 1),
            separatorToLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separatorToLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        contentView.addSubview(buttonForLoging)
        NSLayoutConstraint.activate([
            buttonForLoging.topAnchor.constraint(equalTo: separatorToLabel.bottomAnchor, constant: 25),
            buttonForLoging.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            buttonForLoging.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            buttonForLoging.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40)
        ])
        
        contentView.addSubview(separatorToButton)
        NSLayoutConstraint.activate([
            separatorToButton.topAnchor.constraint(equalTo: buttonForLoging.bottomAnchor, constant: 25),
            separatorToButton.heightAnchor.constraint(equalToConstant: 1),
            separatorToButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separatorToButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: separatorToButton.bottomAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        stackView.addArrangedSubview(buttonForLargeLogin)
        stackView.addArrangedSubview(buttonForSingUp)
    }
}
