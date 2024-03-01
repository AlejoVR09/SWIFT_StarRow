//
//  FavoriteCollectionViewCell.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 8/02/24.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpImage()
        shadowToFatherView()
    }
    
    private func setUpImage(){
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 10
    }
    
    private func shadowToFatherView(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = CGFloat(integerLiteral: 10)
    }
    
    func updateData(movie: MoviesEntity){
        self.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + movie.poster))
        self.title.text = movie.name
        self.releaseDate.text = MoviesEntity.formatShortDate(movie.releaseDate)
    }
}

extension FavoriteCollectionViewCell {
    class func buildFavoriteCell(_ collectionView: UICollectionView, in indexPath: IndexPath, with movie: MoviesEntity) -> FavoriteCollectionViewCell{
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as? Self
        customCell?.updateData(movie: movie)
        return customCell ?? Self()
    }
}
