//
//  RegisterViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

// MARK: Class Declaration
class RegisterViewController: UIViewController {

    private let userDataValidation = UserDataValidation()
    private var registerView: RegisterView
    let userRepository = AppUserRepository()
    
    init(registerView: RegisterView) {
        self.registerView = registerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = registerView
        self.registerView.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: AppConstant.SystemImageNames.chevronBackward), style: .plain, target: self, action: #selector(backToLogin))
    }
}

// MARK: Selectors
extension RegisterViewController {
    @objc func backToLogin(){
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: View Delegate
extension RegisterViewController: RegisterViewDelegate {
    func buttonPressedToSign(_ registerView: RegisterView, withName: String, validName: Bool, withEmail: String, validEmail: Bool, withPhone: String, validPhone: Bool) {
        if validName && validEmail && validPhone {
            guard userRepository.retrieveUser(email: withEmail) == nil else {
                registerView.setEmailErrorText(text: AppConstant.Translations.existingEmail)
                return
            }
            UserSession.currentSessionProfile(currentUserEmail: withEmail)
            userRepository.saveUser(withEmail: withEmail, withName: withName, withPhone: withPhone)
            self.navigationController?.show(TabBarController.buildTabBarController(), sender: nil)
            
        }
        else {
            if !validName {
                registerView.setNameErrorText(text: AppConstant.Translations.invalidName)
            }
            if !validEmail {
                registerView.setEmailErrorText(text: AppConstant.Translations.invalidEmailText)
            }
            if !validPhone {
                registerView.setPhoneErrorText(text: AppConstant.Translations.invalidPhone)
            }
        }
    }
}

// MARK: Builders
extension RegisterViewController {
    class func buildRegisterViewController() -> RegisterViewController {
        let view = RegisterView()
        let controller = RegisterViewController(registerView: view)
        return controller
    }
}
