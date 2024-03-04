//
//  CustomCollectionViewCell.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 30/01/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
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
        label.textColor = UIColor(named: "MainInverse")
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "MainInverse")
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let starView: StarMaskView = StarMaskView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
        backgroundColor = UIColor(named: "Main")
        setShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConstraint()
        setShadow()
    }

    private func setConstraint(){
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
        ])
        
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(dateLabel)
        
        let ratioConstraint = imageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ratioConstraint.priority = UILayoutPriority(900)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            ratioConstraint,
            imageView.trailingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(starView)
        starView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           starView.heightAnchor.constraint(equalToConstant: 50),
           starView.widthAnchor.constraint(equalToConstant: 180),
           starView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
           starView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20),
       ])
    }
    
    private func setShadow(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = CGFloat(integerLiteral: 10)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = CGColor(red: 0.150, green: 0.150, blue: 0.150, alpha: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.5
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
}
