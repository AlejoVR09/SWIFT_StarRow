//
//  StackViewType.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 11/03/24.
//

import UIKit

class StackViewType: UIStackView {
    let orientation: NSLayoutConstraint.Axis
    let innerSpacing: CGFloat
    
    init(orientation: NSLayoutConstraint.Axis, innerSpacing: CGFloat) {
        self.orientation = orientation
        self.innerSpacing = innerSpacing
        super.init(frame: .zero)
        setUpStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView(){
        self.distribution = .fillEqually
        self.spacing = self.innerSpacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = self.orientation
    }
}
