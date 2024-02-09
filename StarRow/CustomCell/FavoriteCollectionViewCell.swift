//
//  FavoriteCollectionViewCell.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 8/02/24.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fatherView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpImage()
        shadowToFatherView()
    }
    
    private func setUpImage(){
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 10
    }
    
    private func shadowToFatherView(){
        self.fatherView.layer.masksToBounds = false
        self.fatherView.layer.cornerRadius = CGFloat(integerLiteral: 10)
    }
}
