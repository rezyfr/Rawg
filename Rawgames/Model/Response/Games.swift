//
//  Games.swift
//  Rawgames
//
//  Created by Fidriyanto R on 09/08/21.
//

import Foundation

struct Games: Codable {
    var results: [Game]
    enum CodingKeys: String, CodingKey {
        case results
    }
}
