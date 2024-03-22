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
        backgroundColor = UIColor(named: AppConstant.Color.mainColor)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setUpCirclebutton()
    }
    
    private let backGroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: AppConstant.ImageNames.backgroundImageShortLogin))
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
        view.backgroundColor = UIColor(named: AppConstant.Color.opacityMainColor)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: AppConstant.Color.inverseColor)
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.text = AppConstant.Translations.loginAs	
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonForLoging: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(named: AppConstant.Color.mainText)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.tintColor = UIColor(named: AppConstant.Color.inverseColor)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToMoviesView), for: .touchUpInside)
        return button
    }()
    
    private let stackView: StackViewType = StackViewType(orientation: .vertical, innerSpacing: 10)
    
    private let buttonForSingUp: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(named: AppConstant.Color.mainText)
        button.layer.cornerRadius = 15
        button.setTitle(AppConstant.Translations.createAccountText, for: .normal)
        button.titleLabel?.tintColor = UIColor(named: AppConstant.Color.inverseColor)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToRegisterView), for: .touchUpInside)
        return button
    }()
    
    private let buttonForLargeLogin: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(named: AppConstant.Color.mainText)
        button.layer.cornerRadius = 15
        button.setTitle(AppConstant.Translations.useAnotherAccount, for: .normal)
        button.titleLabel?.tintColor = UIColor(named: AppConstant.Color.inverseColor)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToLargeLogin), for: .touchUpInside)
        return button
    }()
    
    private let separatorToLabel: SeparatorView = SeparatorView()
    
    private let separatorToButton: SeparatorView = SeparatorView()
    
    private func setUpCirclebutton(){
        self.buttonForLoging.layer.cornerRadius = self.buttonForLoging.bounds.height / 2
    }
    
    func setLogingButtonText(message: String){
        self.buttonForLoging.setTitle(message, for: .normal)
    }
}

extension ShortLoginView {
    @objc private func goToRegisterView(){
        self.delegate.loginViewDidButtonPressedToSignUp(loginView: self)
    }
    
    @objc private func goToMoviesView(){
        self.delegate.loginView?(self, withEmail: self.buttonForLoging.titleLabel?.text ?? "", validEmail: true, remember: true)
    }
    
    @objc private func goToLargeLogin(){
        self.delegate.loginViewGoToLargeLogin?()
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
            contentView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
        
        contentView.addSubview(loginLabel)
        NSLayoutConstraint.activate([
            loginLabel.heightAnchor.constraint(equalToConstant: 50),
            loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            loginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
        
        contentView.addSubview(separatorToLabel)
        NSLayoutConstraint.activate([
            separatorToLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 1),
            separatorToLabel.heightAnchor.constraint(equalToConstant: 1),
            separatorToLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            separatorToLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        contentView.addSubview(buttonForLoging)
        NSLayoutConstraint.activate([
            buttonForLoging.topAnchor.constraint(equalTo: separatorToLabel.bottomAnchor, constant: 25),
            buttonForLoging.widthAnchor.constraint(equalToConstant: 240),
            buttonForLoging.heightAnchor.constraint(equalToConstant: 240),
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
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
        ])
        
        stackView.addArrangedSubview(buttonForLargeLogin)
        stackView.addArrangedSubview(buttonForSingUp)
    }
}
