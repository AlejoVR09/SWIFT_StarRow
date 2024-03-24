//
//  LargeLoginViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import UIKit

// MARK: Class Declaration
class FullLoginView: UIView {
    private var delegate: LoginViewDelegate
    
    init(delegate: LoginViewDelegate){
        bottomConstraint = buttonForLoging.topAnchor.constraint(equalTo: userEmailTextField.bottomAnchor, constant: 20)
        self.delegate = delegate
        super.init(frame: .zero)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        addGestureRecognizer(tapGesture)
        backgroundColor = UIColor(named: AppConstant.Color.mainColor)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let upperImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: AppConstant.ImageNames.loginUpperImage))
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
        label.font = UIFont(name: AppConstant.CustomFont.appTitleFont, size: 30)
        label.textAlignment = .center
        label.text = AppConstant.Translations.appTittle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: AppConstant.Color.opacityInverseColor)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: AppConstant.Color.inverseColor)
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.text = AppConstant.Translations.loginTextTittle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userEmailTextField: MainTextField = MainTextField(withText: AppConstant.Translations.emailPlaceHolder, errorText: AppConstant.Translations.emailCorrectFormat, validationMethod: UserDataValidation.validateEmail(email:), newKeyBoardType: .emailAddress)
    
    private let buttonForLoging: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(named: AppConstant.Color.mainText)
        button.titleLabel?.tintColor = UIColor(named: AppConstant.Color.inverseColor)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.setTitle(AppConstant.Translations.loginText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToMoviesView), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 10)
    
    private let innerStack: UIStackView = StackViewType(orientation: .horizontal, innerSpacing: 10)
    
    private let buttonForRegister: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(named: AppConstant.Color.mainText)
        button.setTitle(AppConstant.Translations.createAccountText, for: .normal)
        button.titleLabel?.tintColor = UIColor(named: AppConstant.Color.inverseColor)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.addTarget(nil, action: #selector(goToRegisterView), for: .touchUpInside)
        return button
    }()
    
    private let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.frame = .zero
        switcher.tintColor = UIColor(named: AppConstant.Color.mainColor)
        switcher.onTintColor = UIColor(named: AppConstant.Color.mainText)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: AppConstant.Color.inverseColor)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = AppConstant.Translations.rememberMe
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorToLabel: SeparatorView = SeparatorView()
    
    private var tapGesture: UITapGestureRecognizer!
    
    private var bottomConstraint: NSLayoutConstraint
    
    func setEmailErrorText(text: String){
        self.userEmailTextField.setErrorMessage(text: text)
    }
}

// MARK: Protocol methods
extension FullLoginView: LoginViewProtocol {
    func keyboardAppear(_ info: Any){
        guard let info = info as? NotificationManager.Info else { return }
        if info.frame.origin.y < self.userEmailTextField.frame.maxY {
            UIView.animate(withDuration: info.animation) {
                self.bottomConstraint.constant = self.userEmailTextField.frame.maxY - info.frame.origin.y + self.bottomConstraint.constant + 20
                self.layoutIfNeeded()
            }
        }
    }
    
    func keyboardDisappear(_ info: Any){
        guard let info = info as? NotificationManager.Info else { return }
        UIView.animate(withDuration: info.animation) {
            self.bottomConstraint.constant = 20
            self.layoutIfNeeded()
        }
    }
}

// MARK: Selectors
extension FullLoginView {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }

    @objc private func goToRegisterView(){
        self.delegate.loginViewDidButtonPressedToSignUp(loginView: self)
    }
    
    @objc private func goToMoviesView(){
        self.delegate.loginView?(self, withEmail: userEmailTextField.text ?? "", validEmail: userEmailTextField.getCurrentState(), remember: self.switcher.isOn)
    }
}

// MARK: Constraints
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
        
        addSubview(userEmailTextField)
        NSLayoutConstraint.activate([
            userEmailTextField.heightAnchor.constraint(equalToConstant: 60),
            userEmailTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            userEmailTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
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


