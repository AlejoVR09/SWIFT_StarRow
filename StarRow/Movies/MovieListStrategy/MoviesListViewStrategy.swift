//
//  MoviesListViewStrategy.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 15/02/24.
//

import Foundation

@objc protocol MoviesListViewStrategy {
    func fetch()
    @objc optional func reloadView()
    @objc optional func pullToRefresh()
}
