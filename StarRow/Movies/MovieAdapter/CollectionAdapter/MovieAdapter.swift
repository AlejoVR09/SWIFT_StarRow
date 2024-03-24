//
//  MovieAdapter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 31/01/24.
//

import Foundation
import UIKit
import CoreData

// MARK: Protocol
protocol MoviesAdapterProtocol: AnyObject {
    var data: [Any] { get set }
    var strategy: AdapterStrategyProtocol { get set }
    func setUpCollectionView(_ collectionView: UICollectionView)
    func setUpErrorCellLayout() -> UICollectionViewCompositionalLayout
    func didSelectHandler(_ handler: @escaping (_ movie: MoviesEntity) -> Void)
}

// MARK: Class declaration
class CollectionViewAdapter: NSObject, MoviesAdapterProtocol{
    private unowned var adapted: UICollectionView?
    var data: [Any] = [] {
        didSet{
            let layout = self.data is [MoviesEntity] && !self.data.isEmpty ? self.strategy.createLayout() : self.setUpErrorCellLayout()
            DispatchQueue.main.async {
                self.adapted?.collectionViewLayout = layout
            }
        }
    }
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
        collectionView.register(UINib(nibName: AppConstant.CellsInfo.errorCellClass, bundle: nil), forCellWithReuseIdentifier: AppConstant.CellsInfo.errorCellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.adapted = collectionView
        self.adapted?.collectionViewLayout = self.strategy.createLayout()
    }
    
    func setUpErrorCellLayout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let layoutGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroup, subitem: item, count: 1)
        group.interItemSpacing = .fixed(0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: Datasource
extension CollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if data.isEmpty {
            data.append(AppConstant.Translations.emptyText)
            return 1
        }
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

// MARK: Delegate
extension CollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = data[indexPath.item] as? MoviesEntity else { return }
        self.didSelect?(movie)
    }
}
