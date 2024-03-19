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
        label.textColor = UIColor(named: AppConstant.Color.inverseColor)
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: AppConstant.Color.inverseColor)
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let starView: StarMaskView = StarMaskView(size: 180)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: AppConstant.Color.mainColor)
        setShadow()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setShadow()
        setConstraint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setShadow()
        setConstraint()
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
        NSLayoutConstraint.activate([
           starView.heightAnchor.constraint(equalToConstant: 20),
           starView.widthAnchor.constraint(equalToConstant: 180),
           starView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
           starView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20),
       ])
    }
    
    private func setShadow(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = CGFloat(integerLiteral: 10)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = CGColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.layer.shadowOpacity = 0.9
        self.layer.shadowRadius = 2.5
    }
    
    private func updatePlaceHolderImage(){
        DispatchQueue.main.async {
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = UIImage(systemName: "person.circle")
        }
    }
    
    func updateData(movie: MoviesEntity){
        self.nameLabel.text = movie.name
        self.dateLabel.text = "\("ReleaseDateText".localized(withComment: "ReleaseDateTextComment".localized())): \n" + LocalDateFormatter.formatDate(movie.releaseDate)
        self.starView.setProgress(num: Float(movie.voteAverage))
        guard let url = URL(string: AppConstant.APIUrl.imageBaseUrl + movie.poster) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                self.updatePlaceHolderImage()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            switch httpResponse.statusCode {
            case 400...500:
                self.updatePlaceHolderImage()
            default:
                guard let imageData = data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData as Data)
                }
            }
        }.resume()
        
    }
}

extension CustomCollectionViewCell {
    class func buildMovieCellOnline(_ collectionView: UICollectionView, in indexPath: IndexPath, with movie: MoviesEntity) -> Self{
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstant.CellsInfo.customCellId, for: indexPath) as? Self
        customCell?.updateData(movie: movie)
        return customCell ?? Self()
    }
}
