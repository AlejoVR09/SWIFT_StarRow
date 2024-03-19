//
//  StringLocalizable.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 18/03/24.
//

import Foundation

extension String {
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
}
