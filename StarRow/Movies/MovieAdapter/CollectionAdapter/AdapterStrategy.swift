//
//  AdapterStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 4/03/24.
//

import Foundation
import UIKit

protocol AdapterStrategyProtocol {
    func registerCell(_ collectionView: UICollectionView)
    func createLayout() -> UICollectionViewCompositionalLayout
    func reusableCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, data: MoviesEntity) -> UICollectionViewCell
}
