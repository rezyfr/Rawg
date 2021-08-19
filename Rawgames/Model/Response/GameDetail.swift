//
//  GameDetail.swift
//  Rawgames
//
//  Created by Fidriyanto R on 15/08/21.
//

struct GameDetailResponse: Codable, Identifiable {
    var gameId: Int
    var id: Int {
        gameId
    }
    var description: String
    var publishers: [PublisherResponse]
    var metacritic: Int

    enum CodingKeys: String, CodingKey {
        case gameId = "id"
        case description = "description_raw"
        case publishers
        case metacritic
    }
}
