//
//  SeparatorView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 12/03/24.
//

import UIKit

class SeparatorView: UIView {

    init() {
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(){
        backgroundColor = UIColor(named: AppConstant.Color.inverseColor)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
