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
        self.title.text = movie.name
        self.releaseDate.text = MoviesEntity.formatShortDate(movie.releaseDate)
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/" + movie.poster) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "star")
                }
                return
            }
            guard let imageData = data else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "star")
                }
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData as Data)
            }
        }.resume()
        
    }
}

extension FavoriteCollectionViewCell {
    class func buildMovieCellLocal(_ collectionView: UICollectionView, in indexPath: IndexPath, with movie: MoviesEntity) -> FavoriteCollectionViewCell{
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as? Self
        customCell?.updateData(movie: movie)
        return customCell ?? Self()
    }
}
