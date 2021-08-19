//
//  Game.swift
//  Rawgames
//
//  Created by Fidriyanto R on 09/08/21.
//

import Foundation

struct Game: Codable, Identifiable {
    let id: Int
    let name: String
    let releaseDate: String
    let rating: Double
    let platforms: [Platforms]
    let backgroundImage: String
    let genre: [Genre]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case releaseDate = "released"
        case rating
        case platforms
        case backgroundImage = "background_image"
        case genre = "genres"
    }
}
