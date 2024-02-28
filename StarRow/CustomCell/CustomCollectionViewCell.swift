//
//  CustomCollectionViewCell.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 30/01/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fatherView: UIView!
    private let starView: StarMaskView = StarMaskView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpImage()
        labelName()
        dateName()
        setUpStarView()
        shadowToFatherView()
    }
    
    private func setUpImage(){
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 10
        self.imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    private func labelName(){
        self.nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private func dateName(){
        self.dateLabel.font = UIFont.italicSystemFont(ofSize: 14)
        //self.dateLabel.
        
    }
    
    private func setUpStarView(){
        fatherView.addSubview(starView)
        starView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starView.heightAnchor.constraint(equalToConstant: 50),
            starView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            starView.trailingAnchor.constraint(equalTo: fatherView.trailingAnchor, constant: -70),
            starView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
        ])
    }
    
    private func shadowToFatherView(){
        self.fatherView.layer.masksToBounds = false
        self.fatherView.layer.cornerRadius = CGFloat(integerLiteral: 10)
        self.fatherView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.fatherView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.fatherView.layer.shadowOpacity = 0.3
        self.fatherView.layer.shadowRadius = 2.5
    }
    
    func updateData(movie: MoviesEntity){
        self.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + movie.poster))
        self.nameLabel.text = movie.name
        self.dateLabel.text = "Release Date: \n" + movie.releaseDate
        self.starView.setProgress(num: Float(movie.voteAverage))
    }
}

extension CustomCollectionViewCell {
    
}

extension CustomCollectionViewCell {
    class func buildMovieCellOnline(_ collectionView: UICollectionView, in indexPath: IndexPath, with movie: MoviesEntity) -> Self{
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomMovieCell", for: indexPath) as? Self
        customCell?.updateData(movie: movie)
        return customCell ?? Self()
    }
    
    class func buildMovieCellLocal(_ collectionView: UICollectionView, in indexPath: IndexPath, with movie: MoviesEntity) -> Self{
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomMovieCell", for: indexPath) as? Self
        customCell?.updateData(movie: movie)
        return customCell ?? Self()
    }
}
