//
//  MovieListBuilder.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 1/02/24.
//

import Foundation
import UIKit

protocol CollectionViewBuilder {
    var collectionView: UICollectionView { get set }
    func build() -> UICollectionView
    func setDataSource(_ dataSource: UICollectionViewDataSource) -> Self
    func setDelegate(_ delegate: UICollectionViewDelegate) -> Self
}

class APICollectionViewBuilder: CollectionViewBuilder {
    var collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    func build() -> UICollectionView {
        return collectionView
    }

    func setDataSource(_ dataSource: UICollectionViewDataSource) -> Self {
        collectionView.dataSource = dataSource
        return self
    }

    func setDelegate(_ delegate: UICollectionViewDelegate) -> Self {
        collectionView.delegate = delegate
        return self
    }
    
    func setFlowLayoutDelegate(_ flowLayout: UICollectionViewDelegateFlowLayout) -> Self {
        collectionView.delegate = flowLayout
        return self
    }
}

class CoreDataCollectionViewBuilder: CollectionViewBuilder {
    var collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    func build() -> UICollectionView {
        return collectionView
    }

    func setDataSource(_ dataSource: UICollectionViewDataSource) -> Self {
        collectionView.dataSource = dataSource
        return self
    }

    func setDelegate(_ delegate: UICollectionViewDelegate) -> Self {
        collectionView.delegate = delegate
        return self
    }
    
    func setFlowLayoutDelegate(_ flowLayout: UICollectionViewDelegateFlowLayout) -> Self {
        collectionView.delegate = flowLayout
        return self
    }
}

class MoviesCollectionViewDirector {
    func createAPICollectionView(withDelegate delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, flowLayout: UICollectionViewDelegateFlowLayout) -> UICollectionView {
        
        return APICollectionViewBuilder(collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
            .setDelegate(delegate)
            .setDataSource(dataSource)
            .setFlowLayoutDelegate(flowLayout)
            .build()
    }

    func createCoreDataCollectionView(withDelegate delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, flowLayout: UICollectionViewDelegateFlowLayout) -> UICollectionView {
        return CoreDataCollectionViewBuilder(collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
            .setDelegate(delegate)
            .setDataSource(dataSource)
            .setFlowLayoutDelegate(flowLayout)
            .build()
    }
}




    

