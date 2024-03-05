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
   
    
    private let starView: StarMaskView = StarMaskView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(named: "Main")
        
        setShadow()
        setUpImage()
        labelName()
        labelDate()
        setConstraint()
        
    }
    
    private func setConstraint(){
        contentView.addSubview(starView)
        starView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           starView.heightAnchor.constraint(equalToConstant: 50),
           starView.widthAnchor.constraint(equalToConstant: 180),
           starView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
           starView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
       ])
    }
    
    private func setUpImage(){
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 10
        self.imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    private func labelName(){
        self.nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.nameLabel.textColor = UIColor(named: "MainInverse")
    }
    
    private func labelDate(){
        self.dateLabel.font = UIFont.italicSystemFont(ofSize: 14)
        self.dateLabel.textColor = UIColor(named: "MainInverse")
    }
    
    private func setShadow(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = CGFloat(integerLiteral: 10)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = CGColor(red: 0.590, green: 0.590, blue: 0.590, alpha: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2.5
    }
    
    func updateData(movie: MoviesEntity){
        self.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + movie.poster))
        self.nameLabel.text = movie.name
        self.dateLabel.text = "Release Date: \n" + MoviesEntity.formatDate(movie.releaseDate)
        self.starView.setProgress(num: Float(movie.voteAverage))
    }
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
