//
//  CustomCollectionViewCell.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 30/01/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    //@IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var nameLabel: UILabel!
    //@IBOutlet weak var dateLabel: UILabel!
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starView: StarMaskView = StarMaskView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(named: "Main")
        
        setShadow()
        setUpImage()
        labelName()
        labelDate()
        
    }
    
    private func setConstraint(){
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.590),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
        
        contentView.addSubview(starView)
        starView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           starView.heightAnchor.constraint(equalToConstant: 50),
           starView.widthAnchor.constraint(equalToConstant: 180),
           starView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
           starView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10),
       ])
        
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(dateLabel)
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
