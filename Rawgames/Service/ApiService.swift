//
//  ApiService.swift
//  Rawgames
//
//  Created by Fidriyanto R on 09/08/21.
//

import Foundation
import SwiftyJSON

private let baseUrl = "https://api.rawg.io/api/"
private let apiKey = "0e047b6cd01040b38ee49753f316c171"

protocol ServiceProtocol {
    func fetchGameList(completion: @escaping ([GameResponse]?) -> Void)
    func fetchGameDetailById(gameId: Int, completion: @escaping (GameDetailResponse?) -> Void)
}

class ApiService: ServiceProtocol {
    func fetchGameList(completion: @escaping ([GameResponse]?) -> Void) {
        guard let url = URL(string: "\(baseUrl)games?key=\(apiKey)") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let games = try? JSONDecoder().decode(GamesResponse.self, from: data) else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(games.results)
            }
        }.resume()
    }

    func fetchGameDetailById(gameId: Int, completion: @escaping (GameDetailResponse?) -> Void) {
        guard let url = URL(string: "\(baseUrl)games/\(gameId)?key=\(apiKey)") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let gameDetail = try? JSONDecoder().decode(GameDetailResponse.self, from: data) else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(gameDetail)
            }
        }.resume()
    }

}
