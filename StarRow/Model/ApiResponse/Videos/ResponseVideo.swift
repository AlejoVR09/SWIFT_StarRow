//
//  ResponseVideo.swift
//  StarRow
//
//  Created by Alejandro Vanegas Rondon on 3/04/24.
//

import Foundation

// MARK: Struct extension for DTO declaration
extension VideoWS {
    struct VideoDTO: Codable {
        let id: Int?
        let results: [Result]?
    }
}

extension VideoWS.VideoDTO {
    // MARK: - Result
    struct Result: Codable {
        let name, key: String?

        enum CodingKeys: String, CodingKey {
            case name, key
        }
    }
}
