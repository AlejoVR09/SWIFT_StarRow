//
//  RegisterView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

// MARK: Delegate protocol
protocol RegisterViewDelegate {
    func buttonPressedToSign(_ registerView: RegisterView, withName: String, validName: Bool, withEmail: String, validEmail: Bool, withPhone: String, validPhone: Bool)
}

// MARK: Class Declaration
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
        let image = UIImageView(image: UIImage(named: AppConstant.ImageNames.backgroundImageRegister))
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
        view.backgroundColor = UIColor(named: AppConstant.Color.opacityMainColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: AppConstant.Color.inverseColor)
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.text = AppConstant.Translations.signUpText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nameStack: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 0)
    
    private let emailStack: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 0)
    
    private let phoneStack: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 0)
    
    private let userNameLabel: UILabel = MainLabel(withText: AppConstant.Translations.namePlaceHolder, color: AppConstant.Color.inverseColor, alignment: .left, size: 16)
    
    private let userEmailLabel: UILabel = MainLabel(withText: AppConstant.Translations.emailPlaceHolder, color: AppConstant.Color.inverseColor, alignment: .left, size: 16)
    
    private let userPhoneLabel: UILabel = MainLabel(withText: AppConstant.Translations.phonePlaceHolder, color: AppConstant.Color.inverseColor, alignment: .left, size: 16)

    private let userNameTextField: MainTextField = MainTextField(withText: AppConstant.Translations.namePlaceHolder, errorText: AppConstant.Translations.nameCorrectFormat, validationMethod: UserDataValidation.validateName(name:), newKeyBoardType: .default)
    
    private let userEmailTextField: MainTextField = MainTextField(withText: AppConstant.Translations.emailPlaceHolder, errorText: AppConstant.Translations.emailCorrectFormat, validationMethod: UserDataValidation.validateEmail(email:), newKeyBoardType: .emailAddress)
    
    private let userPhoneTextField: MainTextField = MainTextField(withText: AppConstant.Translations.phonePlaceHolder, errorText: AppConstant.Translations.phoneCorrectFormat, validationMethod: UserDataValidation.validatePhone(phone:), newKeyBoardType: .phonePad)
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.backgroundColor = UIColor(named: AppConstant.Color.mainText)
        button.titleLabel?.tintColor = UIColor(named: AppConstant.Color.inverseColor)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.setTitle(AppConstant.Translations.signUpText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(goToMoviesView), for: .touchUpInside)
        return button
    }()
    
    private let separatorToLabel: SeparatorView = SeparatorView()
    
    private var tapGesture: UITapGestureRecognizer!
    
    private var bottomConstraint: NSLayoutConstraint
    
    func setNameErrorText(text: String){
        self.userNameTextField.setErrorMessage(text: text)
    }
    
    func setEmailErrorText(text: String){
        self.userEmailTextField.setErrorMessage(text: text)
    }
    
    func setPhoneErrorText(text: String){
        self.userPhoneTextField.setErrorMessage(text: text)
    }
}

// MARK: Selectors
extension RegisterView {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
    @objc private func goToMoviesView(){
        self.delegate?.buttonPressedToSign(self, withName: userNameTextField.text ?? "", validName: userNameTextField.getCurrentState(), withEmail: userEmailTextField.text ?? "", validEmail: userEmailTextField.getCurrentState(), withPhone: userPhoneTextField.text ?? "", validPhone: userPhoneTextField.getCurrentState())
    }
}

// MARK: Constraints
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
        
        contentView.addSubview(signUpLabel)
        NSLayoutConstraint.activate([
            signUpLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            signUpLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            signUpLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
        
        contentView.addSubview(separatorToLabel)
        NSLayoutConstraint.activate([
            separatorToLabel.heightAnchor.constraint(equalToConstant: 1),
            separatorToLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            separatorToLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            separatorToLabel.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 1)
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
