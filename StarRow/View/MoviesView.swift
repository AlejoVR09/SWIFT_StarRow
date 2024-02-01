//
//  MoviesView.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 23/01/24.
//

import UIKit
import Kingfisher

protocol MoviesViewDelegate {
    func didButtonPressedToDetails(moviesView: MoviesView)
}

class MoviesView: UIView {
    
    @IBOutlet private weak var movieCollectionView: UICollectionView!

    var delegate: MoviesViewDelegate?


    var movies: [MoviesWS.Response.Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                self.movieCollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomMovieCell")
                self.movieCollectionView.dataSource = self
                self.movieCollectionView.delegate = self
            }
        }
    }
    
}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

extension MoviesView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didButtonPressedToDetails(moviesView: self)
    }
    
}

extension MoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}

extension MoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellFor = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomMovieCell", for: indexPath)
                    
        guard
            let customCell = cellFor as? CustomCollectionViewCell
        else {
            return UICollectionViewCell()
        }
            
        let movie = movies[indexPath.item]
        customCell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + (movie.posterPath ?? "")))
        customCell.overviewLabel.text = movie.originalTitle ?? ""
        customCell.dateLabel.text = movie.releaseDate ?? ""
        
        return customCell
    }
    
    
}
