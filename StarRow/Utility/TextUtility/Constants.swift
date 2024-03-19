//
//  Constants.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 18/03/24.
//

import Foundation

struct AppConstant {
    struct Color {
        static let mainText = "MainText"
        static let mainColor = "Main"
        static let inverseColor = "MainInverse"
        static let opacityMainColor = "MainOpacity"
        static let opacityInverseColor = "MainOpacityInverse"
    }
    
    struct ImageNames {
        static let loginUpperImage = "UpperImage"
        static let backgroundImageShortLogin = "RowStar2"
        static let backgroundImageRegister = "RowStar1"
    }
    
    struct CustomFont {
        static let appTitleFont = "Marker Felt"
    }
    
    struct RegexValidation {
        static let emailValidation = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        static let nameValidation = "^[a-zA-Z]+$"
        static let phoneValidation = "^[0-9]{7,10}$"
    }
    
    struct CellsInfo {
        static let customCellId = "CustomMovieCell"
        static let errorCellClass = "ErrorCellCollectionViewCell"
        static let errorCellId = "ErrorCell"
        static let favoritesCellClass = "FavoriteCollectionViewCell"
        static let favoritesCellId = "FavoriteCell"
    }
    
    struct APIUrl {
        static let baseUrl = "https://api.themoviedb.org/3/movie/"
        static let moviesUrl = baseUrl + "popular?api_key=176de15e8c8523a92ff640f432966c9c&language="
        static let detailsUrl = "?api_key=752cd23fdb3336557bf3d8724e115570&language="
        static func detailsEndPoint(id: Int) -> String {
            return baseUrl + String(id) + detailsUrl
        }
        static let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    }
}
