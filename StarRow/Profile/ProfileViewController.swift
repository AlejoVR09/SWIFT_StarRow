//
//  ProfileViewController.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 11/03/24.
//

import UIKit

// MARK: Protocol
protocol ProfileViewControllerDelegate {
    func closeViewController(_ profileViewController: ProfileViewController)
}

// MARK: Class declaration
class ProfileViewController: UIViewController {
    
    let profileView: ProfileView
    let delegate: ProfileViewControllerDelegate
    let userProvider = AppUserRepository()
    
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

// MARK: View Delegate
extension ProfileViewController: ProfileViewDelegate {
    func didTapToSingOut(_ profileView: ProfileView) {
        dismiss(animated: true)
        self.delegate.closeViewController(self)
    }
}

// MARK: Builders
extension ProfileViewController {
    class func buildProfileViewController(delegate: ProfileViewControllerDelegate) -> ProfileViewController {
        let view = ProfileView()
        let controller = ProfileViewController(profileView: view, delegate: delegate)
        return controller
    }
}
