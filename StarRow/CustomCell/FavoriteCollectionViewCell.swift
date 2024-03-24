//
//  FavoriteCollectionViewCell.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 8/02/24.
//

import UIKit

// MARK: Class declaration
class FavoriteCollectionViewCell: UICollectionViewCell {
    private var movieSelected: MoviesEntity?
    
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
        self.movieSelected = movie
        self.title.text = movie.name
        self.releaseDate.text = LocalDateFormatter.formatShortDate(movie.releaseDate)
        self.imageView.downloadImage(AppConstant.APIUrl.imageBaseUrl + movie.poster){image, urlImage in
            guard let image = image else { return }
            self.imageView.animateAndSetImage(image)
        }
    }
}

// MARK: Builders
extension FavoriteCollectionViewCell {
    class func buildMovieCellLocal(_ collectionView: UICollectionView, in indexPath: IndexPath, with movie: MoviesEntity) -> FavoriteCollectionViewCell{
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstant.CellsInfo.favoritesCellId, for: indexPath) as? Self
        customCell?.updateData(movie: movie)
        return customCell ?? Self()
    }
}
