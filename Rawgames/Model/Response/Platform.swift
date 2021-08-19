//
//  Platform.swift
//  Rawgames
//
//  Created by Fidriyanto R on 09/08/21.
//

import Foundation

struct Platforms: Codable {
    let platform: Platform
//    let requirements: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
//        case requirements = "requirements_en"
    }
}

struct Platform: Codable, Hashable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}
