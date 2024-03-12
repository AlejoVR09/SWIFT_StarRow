//
//  ProfileView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 11/03/24.
//

import UIKit

protocol ProfileViewDelegate {
    func didTapToSingOut(_ profileView: ProfileView)
}

class ProfileView: UIView {
    var delegate: ProfileViewDelegate?
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setContraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("asd", for: .normal)
        button.addTarget(nil, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    
    
    private func setContraint(){
        addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            signOutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            signOutButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            signOutButton.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}

extension ProfileView {
    @objc func signOut(){
        self.delegate?.didTapToSingOut(self)
    }
}
