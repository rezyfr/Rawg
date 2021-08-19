//
//  Genre.swift
//  Rawgames
//
//  Created by Fidriyanto R on 09/08/21.
//

import Foundation

struct GenreResponse: Codable, Hashable {
    let genreId: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case name
    }
}
