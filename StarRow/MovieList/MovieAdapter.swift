//
//  MovieAdapter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 31/01/24.
//

import Foundation
import UIKit
import Kingfisher
import CoreData

protocol apiAdapterDelegate {
    func didSelectMovieToDetails(_ apiAdapter: APICollectionViewAdapter, indexPath: IndexPath)
}

protocol coreDataAdapterDelegate {
    func didSelectButtonToDelete(_ coreDataAdapter: CoreDataCollectionViewAdapter, indexPath: IndexPath)
}

class APICollectionViewAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var delegate: apiAdapterDelegate?
    var apiData: [MoviesWS.Response.Movie]
    init(apiData: [MoviesWS.Response.Movie]) {
        self.apiData = apiData
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectMovieToDetails(self, indexPath: indexPath)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellFor = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomMovieCell", for: indexPath)
                    
        guard
            let customCell = cellFor as? CustomCollectionViewCell
        else {
            return UICollectionViewCell()
        }
            
        let movie = apiData[indexPath.item]
        customCell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + (movie.posterPath ?? "")))
        customCell.overviewLabel.text = movie.title ?? ""
        customCell.dateLabel.text = movie.releaseDate ?? ""
        
        return customCell
    }
}

class CoreDataCollectionViewAdapter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: coreDataAdapterDelegate?
    var coreDataObjects: [MovieCoreData]
    
    init(coreDataObjects: [MovieCoreData]) {
        self.coreDataObjects = coreDataObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectButtonToDelete(self, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2 - 10,height: UIScreen.main.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellFor = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath)
                    
        guard
            let customCell = cellFor as? FavoriteCollectionViewCell
        else {
            return UICollectionViewCell()
        }
            
        let movie = coreDataObjects[indexPath.item]
        
        customCell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/" + (movie.posterPath ?? "")))
        customCell.title.text = movie.originalTitle ?? ""
        customCell.releaseDate.text = movie.releaseDate ?? ""
        return customCell
    }
}
