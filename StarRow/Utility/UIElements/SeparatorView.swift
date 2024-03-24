//
//  SeparatorView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 12/03/24.
//

import UIKit

// MARK: Delegate protocol
class SeparatorView: UIView {

    init() {
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpView(){
        backgroundColor = UIColor(named: AppConstant.Color.inverseColor)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
