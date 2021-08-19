//
//  Game.swift
//  Rawgames
//
//  Created by Fidriyanto R on 09/08/21.
//

import Foundation

struct GameResponse: Codable, Identifiable {
    let idGame: Int
    let name: String
    let releaseDate: String
    let rating: Double
    let platforms: [PlatformsResponse]
    let backgroundImage: String
    let genre: [GenreResponse]

    var id: Int {
        idGame
    }
    enum CodingKeys: String, CodingKey {
        case idGame = "id"
        case name
        case releaseDate = "released"
        case rating
        case platforms
        case backgroundImage = "background_image"
        case genre = "genres"
    }
}
