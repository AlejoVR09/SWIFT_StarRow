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
    let userProvider = AppUserCoreDataProvider()
    
    init(profileView: ProfileView, delegate: ProfileViewControllerDelegate) {
        self.profileView = profileView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = profileView
        self.profileView.delegate = self
        self.profileView.setUserData(user: userProvider.retrieveUser(email: UserSession.getCurrentSessionProfile()))
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func didTapToSingOut(_ profileView: ProfileView) {
        dismiss(animated: true)
        self.delegate.closeViewController(self)
    }
}
