//
//  Games.swift
//  Rawgames
//
//  Created by Fidriyanto R on 09/08/21.
//

import Foundation

struct GamesResponse: Codable {
    var results: [GameResponse]
    enum CodingKeys: String, CodingKey {
        case results
    }
}
