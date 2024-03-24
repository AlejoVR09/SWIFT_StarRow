//
//  MainTextField.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 11/03/24.
//

import UIKit

// MARK: Delegate protocol
class MainTextField: UITextField {
    private var withText: String
    private var errorText: String
    private var validationMethod: (_ text :String) -> Bool
    private var newKeyBoardType: UIKeyboardType
    private var currentState: Bool = false
    
    init(withText: String, errorText: String, validationMethod: @escaping (_ text: String) -> Bool, newKeyBoardType: UIKeyboardType) {
        self.withText = withText
        self.errorText = errorText
        self.validationMethod = validationMethod
        self.newKeyBoardType = newKeyBoardType
        super.init(frame: .zero)
        setUpTextField(text: withText)
        setUpLabel()
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private func setUpTextField(text: String){
        self.keyboardType = self.newKeyBoardType
        self.backgroundColor = .init(white: 0, alpha: 0)
        self.placeholder = text
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = UIColor(named: AppConstant.Color.inverseColor)
        self.layer.borderColor = UIColor(named: AppConstant.Color.mainText)?.cgColor
        self.layer.borderWidth = 1
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpLabel(){
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            errorLabel.heightAnchor.constraint(equalToConstant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        errorLabel.text = errorText
    }
    
    func getCurrentState() -> Bool {
        return self.currentState
    }
    
    func setErrorMessage(text: String){
        self.errorLabel.text = text
        self.errorLabel.isHidden = false
    }
    
    @objc func textFieldDidChange(){
        guard let text = text else { return }
        if validationMethod(text) {
            self.errorLabel.isHidden = true
            self.currentState = true
        }
        else {
            if text.isEmpty {
                self.errorLabel.isHidden = true
            }
            else {
                self.errorLabel.text = self.errorText
                self.errorLabel.isHidden = false
            }
            self.currentState = false
        }
    }
}
