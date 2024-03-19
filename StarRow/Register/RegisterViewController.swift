//
//  RegisterViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class RegisterViewController: UIViewController {

    private let userDataValidation = UserDataValidation()
    private var registerView: RegisterView
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(registerView: RegisterView) {
        self.registerView = registerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = registerView
        self.registerView.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BackButtonText".localized(withComment: "BackButtonTextComment".localized()), style: .plain, target: self, action: #selector(backToLogin))
    }
}

extension RegisterViewController {
    @objc func backToLogin(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func buttonPressedToSign(_ registerView: RegisterView, withName: String, validName: Bool, withEmail: String, validEmail: Bool, withPhone: String, validPhone: Bool) {
        if validName && validEmail && validPhone {
            guard verifyExistingUser(email: withEmail) else {
                registerView.setEmailErrorText(text: "existingEmail".localized(withComment: "existingEmailComment".localized()))
                return
            }
            let user = AppUser(context: self.context)
            user.email = withEmail
            user.name = withName
            user.phone = withPhone
            do {
                try self.context.save()
                UserSession.currentSessionProfile(currentUserEmail: withEmail)
                self.navigationController?.show(TabBarController(), sender: nil)
            }
            catch{
                print(error)
            }
        }
        else {
            if !validName {
                registerView.setNameErrorText(text: "invalidName".localized(withComment: "invalidNameComment".localized()))
            }
            if !validEmail {
                registerView.setEmailErrorText(text: "invalidEmail".localized(withComment: "invalidEmailComment".localized()))
            }
            if !validPhone {
                registerView.setPhoneErrorText(text: "invalidPhone".localized(withComment: "invalidPhoneComment".localized()))
            }
        }
    }
    
    func verifyExistingUser(email: String) -> Bool {
        let usersInApp = self.retrieveData()
        let result = usersInApp.first { $0.email == email }
        guard result != nil else { return true }
        return false
    }
    
    private func retrieveData() -> [AppUser]{
        do{
            let users = try self.context.fetch(AppUser.fetchRequest())
            return users
        }
        catch {
            return []
        }
    }
}
