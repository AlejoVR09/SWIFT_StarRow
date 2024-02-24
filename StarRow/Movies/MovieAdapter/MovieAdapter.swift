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
    
    private unowned var adaptated: UICollectionView?
    var delegate: AdapterDelegate?
    var data: [MoviesEntity] = []
    
    func setUpCollectionView(_ collectionView: UICollectionView){
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomMovieCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.adaptated = collectionView
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
        return CustomCollectionViewCell.buildMovieCell(collectionView, in: indexPath, with: data[indexPath.item])
    }
}

class CoreDataCollectionViewAdapter: NSObject, AdapterProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private unowned var adaptated: UICollectionView?
    var delegate: AdapterDelegate?
    var data: [MoviesEntity] = []
    
    func setUpCollectionView(_ collectionView: UICollectionView){
        collectionView.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.adaptated = collectionView
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
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCollectionViewCell
        customCell?.updateData(movie: data[indexPath.item])
        return customCell ?? UICollectionViewCell()
    }
}
