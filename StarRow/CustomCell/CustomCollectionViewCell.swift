//
//  CustomCollectionViewCell.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 30/01/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fatherView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        setUpImage()
        shadowToFatherView()
        
    }
    
    private func setUpImage(){
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 10
        self.imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    private func shadowToFatherView(){
        self.fatherView.layer.masksToBounds = false
        self.fatherView.layer.cornerRadius = CGFloat(integerLiteral: 10)
        //self.fatherView.layer.borderWidth = 0.5
        self.fatherView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.fatherView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.fatherView.layer.shadowOpacity = 0.5
        self.fatherView.layer.shadowRadius = 2.5
    }

}
