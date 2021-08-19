//
//  GameDetail.swift
//  Rawgames
//
//  Created by Fidriyanto R on 15/08/21.
//

struct GameDetail: Codable, Identifiable {
    var id: Int
    var description: String
    var publishers: [Publisher]
    var metacritic: Int

    enum CodingKeys: String, CodingKey {
        case id
        case description = "description_raw"
        case publishers
        case metacritic
    }
}
