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


protocol AdapterProtocol: AnyObject {
    var delegate: AdapterDelegate? { get set }
    var data: [MoviesEntity] { get set }
    func setUpCollectionView(_ collectionView: UICollectionView)
}

protocol AdapterDelegate: AnyObject {
    func didSelectMovie(_ apiAdapter: AdapterProtocol, indexPath: IndexPath)
}

class APICollectionViewAdapter: NSObject, AdapterProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private unowned var adaptated: UICollectionView?
    weak var delegate: AdapterDelegate?
    var data: [MoviesEntity] = []
    
    func setUpCollectionView(_ collectionView: UICollectionView){
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomMovieCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.adaptated = collectionView
        setCompositionalLayout()
    }
    
    private func setCompositionalLayout() {
        //definir layout con dimension de la celda
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        //definir un grupo en horizontal o vertical segun direccion de scroll. es un conjutno de items
        let layoutGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroup, subitem: item, count: 1)
        //definir la seccion que es un conjunto de grupos
        let section = NSCollectionLayoutSection(group: group)
        //defines atributos del collection como espacio, direccion, interlineado, etc..
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)
        section.interGroupSpacing = 20
        //creas el layout del collection y se lo asignas...
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.adaptated?.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectMovie(self, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return CustomCollectionViewCell.buildMovieCellOnline(collectionView, in: indexPath, with: data[indexPath.item])
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
        setCompositionalLayout()
    }
    
    private func setCompositionalLayout() {
        //definir layout con dimension de la celda
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        //definir un grupo en horizontal o vertical segun direccion de scroll. es un conjutno de items
        let layoutGroup = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(.leastNormalMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroup, subitem: item, count: 2)
        group.interItemSpacing = .fixed(20)
        //definir la seccion que es un conjunto de grupos
        let section = NSCollectionLayoutSection(group: group)
        //defines atributos del collection como espacio, direccion, interlineado, etc..
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)
        section.interGroupSpacing = 20
        //creas el layout del collection y se lo asignas...
        let layout = UICollectionViewCompositionalLayout(section: section)
        self.adaptated?.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectMovie(self, indexPath: indexPath)
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
