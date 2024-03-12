//
//  MainTextField.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 11/03/24.
//

import UIKit

class MainTextField: UITextField {
    var withText: String
    
    init(withText: String) {
        self.withText = withText
        super.init(frame: .zero)
        setUpTextField(text: withText)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpTextField(text: String){
        self.backgroundColor = .init(white: 0, alpha: 0)
        self.placeholder = text
        self.font = UIFont(name: "Marker Felt", size: 16)
        self.textColor = UIColor(named: "Main")
        self.layer.borderColor = UIColor(named: "MainText")?.cgColor
        self.layer.borderWidth = 1
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
