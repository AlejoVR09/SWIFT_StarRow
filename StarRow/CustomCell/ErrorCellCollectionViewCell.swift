//
//  ErrorCellCollectionViewCell.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 14/03/24.
//

import UIKit

class ErrorCellCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateData(text: String){
        
    }
}

extension ErrorCellCollectionViewCell {
    class func buildMovieCellError(_ collectionView: UICollectionView, in indexPath: IndexPath, with text: String) -> Self {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomMovieCell", for: indexPath) as? Self
        customCell?.updateData(text: text)
        return customCell ?? Self()
    }
}
