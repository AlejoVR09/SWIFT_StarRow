//
//  MovieAdapter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 31/01/24.
//

import Foundation
import UIKit
import CoreData


protocol MoviesAdapterProtocol: AnyObject {
    var data: [Any] { get set }
    var strategy: AdapterStrategyProtocol { get set }
    func setUpCollectionView(_ collectionView: UICollectionView)
    func didSelectHandler(_ handler: @escaping (_ movie: MoviesEntity) -> Void)
}

class CollectionViewAdapter: NSObject, MoviesAdapterProtocol{
    
    private unowned var adapted: UICollectionView?
    var data: [Any] = []
    var strategy: AdapterStrategyProtocol
    private var didSelect: ((_ movie: MoviesEntity) -> Void)?
    
    init(strategy: AdapterStrategyProtocol) {
        self.strategy = strategy
    }
    
    func didSelectHandler(_ handler: @escaping (_ movie: MoviesEntity) -> Void) {
        self.didSelect = handler
    }
    
    func setUpCollectionView(_ collectionView: UICollectionView){
        self.strategy.registerCell(collectionView)
        collectionView.register(UINib(nibName: "ErrorCellCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ErrorCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.adapted = collectionView
        self.adapted?.collectionViewLayout = self.strategy.createLayout()
    }
}

extension CollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.data[indexPath.row]
        if let message = item as? String {
            return ErrorCellCollectionViewCell.buildMovieCellError(collectionView, in: indexPath, with: message)
        } else if let movie = item as? MoviesEntity {
            return self.strategy.reusableCell(collectionView, cellForItemAt: indexPath, data: movie)
        } else {
            return UICollectionViewCell()
        }
    }
}

extension CollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = data[indexPath.item] as? MoviesEntity else { return }
        self.didSelect?(movie)
    }
}
