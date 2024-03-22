//
//  LocalDateFormatter.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 18/03/24.
//

import Foundation

// MARK: Class declaration
struct LocalDateFormatter {
    // MARK: Normal Date Format
    static func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.dateFormat = AppConstant.DateFormats.dateFormat
        
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        
        let dayName = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1].capitalized
        let day = Calendar.current.component(.day, from: date)
        let month = dateFormatter.monthSymbols[Calendar.current.component(.month, from: date) - 1]
        let year = Calendar.current.component(.year, from: date)
        
        switch Locale.current.language.languageCode {
        case "es":
            return "\(dayName), \(day) de \(month) del \(year)"
        default:
            return "\(dayName), \(month) \(day) of \(year)"
        }
        
    }
    
    // MARK: Short Date Format
    static func formatShortDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.dateFormat = AppConstant.DateFormats.dateFormat
        
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        
        let day = Calendar.current.component(.day, from: date)
        let month = dateFormatter.monthSymbols[Calendar.current.component(.month, from: date) - 1]
        let year = Calendar.current.component(.year, from: date)
        
        return "\(day) \(month) \(year)"
    }
}
