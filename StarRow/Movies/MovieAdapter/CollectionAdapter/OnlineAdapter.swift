//
//  OnlineAdapter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 4/03/24.
//

import Foundation
import UIKit

// MARK: Class declaration
class OnlineAdapterStrategy: AdapterStrategyProtocol {
    func countDataSource() -> String {
        AppConstant.Translations.noServiceAvaible
    }
    
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: AppConstant.CellsInfo.customCellId)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let layoutGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroup, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        section.interGroupSpacing = 20
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func reusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, data: MoviesEntity) -> UICollectionViewCell {
        return CustomCollectionViewCell.buildMovieCellOnline(collectionView, in: indexPath, with: data)
    }
}
