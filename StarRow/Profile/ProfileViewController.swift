//
//  ProfileViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 11/03/24.
//

import UIKit

protocol ProfileViewControllerDelegate {
    func closeViewController(_ profileViewController: ProfileViewController)
}

class ProfileViewController: UIViewController {
    
    let profileView: ProfileView
    let delegate: ProfileViewControllerDelegate
    
    init(profileView: ProfileView, delegate: ProfileViewControllerDelegate) {
        self.profileView = profileView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = profileView
        self.profileView.delegate = self
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func didTapToSingOut(_ profileView: ProfileView) {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        dismiss(animated: true)
        self.delegate.closeViewController(self)
    }
}
