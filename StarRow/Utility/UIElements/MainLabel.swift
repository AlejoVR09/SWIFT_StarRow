//
//  MainLabel.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 11/03/24.
//

import UIKit

class MainLabel: UILabel {

    let withText: String
    let alignment: NSTextAlignment
    let color: String
    let size: CGFloat
    
    init(withText: String, color: String, alignment: NSTextAlignment, size: CGFloat) {
        self.withText = withText
        self.alignment = alignment
        self.color = color
        self.size = size
        super.init(frame: .zero)
        setUpLabel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLabel(){
        self.textColor = .black
        self.textColor = UIColor(named: self.color)
        self.font = UIFont.systemFont(ofSize: self.size)
        self.textAlignment = self.alignment
        self.text = self.withText
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
