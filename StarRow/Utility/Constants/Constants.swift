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
    
    struct SystemImageNames {
        static let starFill = "star.fill"
        static let star = "star"
        static let personCircle = "person.circle"
        static let squareSplit = "square.split.2x2"
        static let squareSplitFill = "square.split.2x2.fill"
        static let chevronBackward = "chevron.backward"
        static let exclamationmarkTriangle = "exclamationmark.triangle"
        static let playCircleFill = "play.circle.fill"
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
        static let moviesUrl = baseUrl + "popular?api_key=176de15e8c8523a92ff640f432966c9c&language=" + "\(Locale.current.language.languageCode ?? "")"
        static let detailsUrl = "?api_key=752cd23fdb3336557bf3d8724e115570&language=" + "\(Locale.current.language.languageCode ?? "")"
        static func detailsEndPoint(id: Int) -> String {
            return baseUrl + String(id) + detailsUrl
        }
        static let videoUrl = "/videos?api_key=176de15e8c8523a92ff640f432966c9c&language="
        static func videoEndPoint(id: Int) -> String {
            return baseUrl + String(id) + videoUrl
        }
        static let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    }
    
    struct DateFormats {
        static let dateFormat = "yyyy-MM-dd"
    }
    
    struct Translations {
        static let appTittle = "appTittle".localized(withComment: "appTittleComment".localized())
        static let loginTextTittle = "loginTextTittle".localized(withComment: "loginTextTittleComment".localized())
        static let rememberMe = "rememberMe".localized(withComment: "rememberMeComment".localized())
        static let emailPlaceHolder = "emailPlaceHolder".localized(withComment: "emailPlaceHolderComment".localized())
        static let emailCorrectFormat = "emailCorrectFormat".localized(withComment: "emailCorrectFormatComment".localized())
        static let invalidEmailText = "invalidEmail".localized(withComment: "invalidEmailComment".localized())
        static let notExistingEmailText = "notExistingEmail".localized(withComment: "notExistingEmailComment".localized())
        
        static let namePlaceHolder = "namePlaceHolder".localized(withComment: "namePlaceHolderComment".localized())
        static let nameCorrectFormat = "nameCorrectFormat".localized(withComment: "nameCorrectFormatComment".localized())
        static let phonePlaceHolder = "phonePlaceHolder".localized(withComment: "phonePlaceHolderComment".localized())
        static let phoneCorrectFormat = "phoneCorrectFormat".localized(withComment: "phoneCorrectFormatComment".localized())
        static let signUpText = "signUpTextButton".localized(withComment: "signUpTextButtonComment".localized())
        static let signOutText = "signOutText".localized(withComment: "signOutTextComment".localized())
        
        static let invalidName = "invalidName".localized(withComment: "invalidNameComment".localized())
        static let invalidPhone = "invalidPhone".localized(withComment: "invalidPhoneComment".localized())
        static let existingEmail = "existingEmail".localized(withComment: "existingEmailComment".localized())
        static let createAccountText = "createAccountText".localized(withComment: "createAccountTextComment".localized())
        
        static let loginAs = "loginAs".localized(withComment: "loginAsComment".localized())
        static let loginText = "loginText".localized(withComment: "loginTextComment".localized())
        static let useAnotherAccount = "useAnotherAccount".localized(withComment: "useAnotherAccountComment".localized())
        
        static let moviesTab = "MoviesTab".localized(withComment: "MoviesTabComment".localized())
        static let FavoritesTab = "FavoritesTab".localized(withComment: "FavoritesTabComment".localized())
        
        static let searchBarPlaceHolder = "SearchBarPlaceHolder".localized(withComment: "SearchBarPlaceHolderComment".localized())
        
        static let elementsNotFound = "elementsNoFoundText".localized(withComment: "elementsNoFoundTextComment".localized())
        static let emptyText = "EmptyText".localized(withComment: "EmptyTextComment".localized())
        
        static let releaseDateText = "ReleaseDateText".localized(withComment: "ReleaseDateTextComment".localized())
        static let emptyDescription = "emptyDescription".localized(withComment: "emptyDescriptionComment".localized())
        static let backButtonText = "BackButtonText".localized(withComment: "BackButtonTextComment".localized())
        static let movieDetailsTittle = "MovieDetailsTittle".localized(withComment: "MovieDetailsTittleComment".localized())
        static let genrerText = "GenrerText".localized(withComment: "GenrerTextComment".localized())
        static let descriptionText = "DescriptionText".localized(withComment: "DescriptionTextComment".localized())
        
        static let noServiceAvaible = "noServiceAvaible".localized(withComment: "noServiceAvaibleComment".localized())
    }
    
    struct LangugeCode {
        static let spanishCode = "es"
    }
    
    struct UserDefaultsKeys {
        static let isLoggedIn = "isLoggedIn"
        static let emailLogged = "emailLogged"
    }
}
