//
//  Publisher.swift
//  Rawgames
//
//  Created by Fidriyanto R on 15/08/21.
//

struct PublisherResponse: Codable, Identifiable, Hashable {
    var id: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
