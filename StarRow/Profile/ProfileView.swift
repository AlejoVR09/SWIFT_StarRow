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
        backgroundColor = UIColor(named: AppConstant.Color.mainColor)
        setContraint()
        setUpLabelData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setContraint()
        setUpLabelData()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    private var imageProfile: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.circle")
        return image
    }()
    
    private var separatorToImage: SeparatorView = SeparatorView()
    
    private var stackInfo: StackViewType = StackViewType(orientation: .vertical, innerSpacing: 40)
    
    private let userNameLabel: UILabel = MainLabel(withText: "namePlaceHolder".localized(withComment: "namePlaceHolderComment".localized()), color: AppConstant.Color.inverseColor, alignment: .center, size: 20)
    
    private let emailStack: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 10)
    
    private let phoneStack: UIStackView = StackViewType(orientation: .vertical, innerSpacing: 10)
    
    private let userEmailLabel: UILabel = MainLabel(withText: "emailPlaceHolder".localized(withComment: "emailPlaceHolderComment".localized()), color: AppConstant.Color.inverseColor, alignment: .center, size: 20)
    
    private let userPhoneLabel: UILabel = MainLabel(withText: "phonePlaceHolder".localized(withComment: "phonePlaceHolderComment".localized()), color: AppConstant.Color.inverseColor, alignment: .center, size: 20)
    
    private let userEmailData: UILabel = MainLabel(withText: "Name@domain.com", color: AppConstant.Color.inverseColor, alignment: .center, size: 16)
    
    private let userPhoneData: UILabel = MainLabel(withText: "+00 11111111111", color: AppConstant.Color.inverseColor, alignment: .center, size: 16)
    
    private var separatorToInfo: SeparatorView = SeparatorView()
    
    private var signOutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("signOutText".localized(withComment: "signOutTextComment".localized()), for: .normal)
        button.backgroundColor = UIColor(named: AppConstant.Color.mainText)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.titleLabel?.tintColor = UIColor(named: AppConstant.Color.inverseColor)
        button.addTarget(nil, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    private func setUpLabelData(){
        addBorder(element: userEmailData)
        addBorder(element: userPhoneData)
    }
    
    private func addBorder(element: UILabel){
        element.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        element.layer.borderWidth = 1
        element.layer.cornerRadius = 10
    }
    
    func setUserData(user: AppUser?){
        userNameLabel.text = user?.name
        userEmailData.text = user?.email
        userPhoneData.text = user?.phone
    }
}

extension ProfileView {
    @objc func signOut(){
        self.delegate?.didTapToSingOut(self)
    }
}

extension ProfileView {
    private func setContraint(){
        addSubview(imageProfile)
        NSLayoutConstraint.activate([
            imageProfile.heightAnchor.constraint(equalToConstant: 120),
            imageProfile.widthAnchor.constraint(equalToConstant: 120),
            imageProfile.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            imageProfile.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        ])
        
        addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 10),
            userNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            userNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5)
        ])
        
        addSubview(separatorToImage)
        NSLayoutConstraint.activate([
            separatorToImage.heightAnchor.constraint(equalToConstant: 1),
            separatorToImage.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
            separatorToImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            separatorToImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5)
        ])
        
        addSubview(stackInfo)
        NSLayoutConstraint.activate([
            stackInfo.topAnchor.constraint(equalTo: separatorToImage.bottomAnchor, constant: 20),
            stackInfo.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackInfo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
        
        stackInfo.addArrangedSubview(emailStack)
        emailStack.addArrangedSubview(userEmailLabel)
        emailStack.addArrangedSubview(userEmailData)
        
        stackInfo.addArrangedSubview(phoneStack)
        phoneStack.addArrangedSubview(userPhoneLabel)
        phoneStack.addArrangedSubview(userPhoneData)
        
        addSubview(separatorToInfo)
        NSLayoutConstraint.activate([
            separatorToInfo.heightAnchor.constraint(equalToConstant: 1),
            separatorToInfo.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            separatorToInfo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5)
        ])
        
        addSubview(signOutButton)
        NSLayoutConstraint.activate([
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            signOutButton.topAnchor.constraint(equalTo: separatorToInfo.bottomAnchor, constant: 10),
            signOutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signOutButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            signOutButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
    }
}
