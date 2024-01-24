//
//  MoviesView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 23/01/24.
//

import UIKit

protocol MoviesViewDelegate {
    func didButtonPressedToDetails(moviesView: MoviesView)
}

class MoviesView: UIView {
    var delegate: MoviesViewDelegate?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func details(_ sender: UIButton) {
        delegate?.didButtonPressedToDetails(moviesView: self)
    }
}
