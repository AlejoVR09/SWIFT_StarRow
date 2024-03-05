//
//  MovieAdapter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 31/01/24.
//

import Foundation
import UIKit
import CoreData


protocol AdapterProtocol: AnyObject {
    var delegate: AdapterDelegate? { get set }
    var data: [MoviesEntity] { get set }
    var strategy: AdapterStrategyProtocol { get set }
    func setUpCollectionView(_ collectionView: UICollectionView)
}

protocol AdapterDelegate: AnyObject {
    func didSelectMovie(_ apiAdapter: AdapterProtocol, indexPath: IndexPath)
}

class CollectionViewAdapter: NSObject, AdapterProtocol, UICollectionViewDelegate, UICollectionViewDataSource{
    
    private unowned var adapted: UICollectionView?
    weak var delegate: AdapterDelegate?
    var data: [MoviesEntity] = []
    var strategy: AdapterStrategyProtocol
    
    init(strategy: AdapterStrategyProtocol) {
        self.strategy = strategy
    }
    
    func setUpCollectionView(_ collectionView: UICollectionView){
        self.strategy.registerCell(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.adapted = collectionView
        self.adapted?.collectionViewLayout = self.strategy.createLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectMovie(self, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.strategy.reusableCell(collectionView, cellForItemAt: indexPath, data: self.data[indexPath.item])
    }
}
