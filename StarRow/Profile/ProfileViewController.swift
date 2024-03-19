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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        self.profileView.setUserData(user: retrieveUser(email: UserSession.getCurrentSessionProfile()))
    }
}

extension ProfileViewController {
    func retrieveUser(email: String) -> AppUser? {
        let moviesSaved = self.retrieveData()
        let result = moviesSaved.first { $0.email == email }
        guard let result = result else { return nil }
        return result
    }
    
    private func retrieveData() -> [AppUser]{
        do{
            let movies = try self.context.fetch(AppUser.fetchRequest())
            return movies
        }
        catch {
            return []
        }
    }
}

extension ProfileViewController: ProfileViewDelegate {
    func didTapToSingOut(_ profileView: ProfileView) {
        dismiss(animated: true)
        self.delegate.closeViewController(self)
    }
}
