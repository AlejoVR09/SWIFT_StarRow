//
//  ErrorCellCollectionViewCell.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 14/03/24.
//

import UIKit

class ErrorCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var warningLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLabel()
        
    }
    
    private func setUpLabel(){
        warningLabel.textColor = UIColor(named: AppConstant.Color.inverseColor)
        warningLabel.font = UIFont.systemFont(ofSize: 16)
        warningLabel.textAlignment = .center
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func updateData(text: String){
        self.warningLabel.text = text
    }
}

extension ErrorCellCollectionViewCell {
    class func buildMovieCellError(_ collectionView: UICollectionView, in indexPath: IndexPath, with text: String) -> Self {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstant.CellsInfo.errorCellId, for: indexPath) as? Self
        customCell?.updateData(text: text)
        return customCell ?? Self()
    }
}
