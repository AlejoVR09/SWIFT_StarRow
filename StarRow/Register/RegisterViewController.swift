//
//  RegisterViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 24/01/24.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerView: RegisterView? {
        self.view as? RegisterView
    }
    
    lazy var notificationManager = NotificationManager(notificationManagerDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerView?.delegate = self
        self.navigationItem.title = "Sing up"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.notificationManager.registerObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.notificationManager.removeObserver()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func buttonPressedToSign(_ registerView: RegisterView) {
        let movieController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieView")
        self.navigationController?.show(movieController, sender: nil)
    }
}

extension RegisterViewController: NotificationManagerDelegate {
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillShow info: NotificationManager.Info) {
        self.registerView?.keyBoardWillShow(info)
    }
    
    func NotificationManagerDelegate(_ notificationManager: NotificationManager, keyboardWillHide info: NotificationManager.Info) {
        self.registerView?.keyBoardWillHide(info)
    }
}
