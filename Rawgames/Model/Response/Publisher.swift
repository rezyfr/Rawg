//
//  Publisher.swift
//  Rawgames
//
//  Created by Fidriyanto R on 15/08/21.
//

struct Publisher: Codable, Identifiable {
    var id: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
