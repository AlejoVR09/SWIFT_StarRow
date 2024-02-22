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


protocol AdapterProtocol {
    var delegate: AdapterDelegate? { get set }
    var data: [MoviesEntity] { get set }
    func setUpCollectionView(_ collectionView: UICollectionView)
}

protocol AdapterDelegate {
    func didSelectMovie(_ apiAdapter: AdapterProtocol, indexPath: IndexPath)
}

class APICollectionViewAdapter: NSObject, AdapterProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var delegate: AdapterDelegate?
    private unowned var adaptated: UICollectionView?
    var data: [MoviesEntity] = []
    
    func setUpCollectionView(_ collectionView: UICollectionView){
        self.adaptated = collectionView
        self.adaptated?.dataSource = self
        self.adaptated?.delegate = self
        self.adaptated?.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomMovieCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectMovie(self, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
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

        customCell.updateData(movie: data[indexPath.item])
        return customCell
    }
}

class CoreDataCollectionViewAdapter: NSObject, AdapterProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var delegate: AdapterDelegate?
    private unowned var adaptated: UICollectionView?
    var data: [MoviesEntity] = []
    
    func setUpCollectionView(_ collectionView: UICollectionView){
        self.adaptated = collectionView
        self.adaptated?.dataSource = self
        self.adaptated?.delegate = self
        self.adaptated?.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectMovie(self, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2 - 10,height: UIScreen.main.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellFor = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath)
                    
        guard
            let customCell = cellFor as? FavoriteCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        customCell.updateData(movie: data[indexPath.item])
        return customCell
    }
}
