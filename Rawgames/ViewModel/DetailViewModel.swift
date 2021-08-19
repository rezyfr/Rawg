//
//  DetailViewModel.swift
//  Rawgames
//
//  Created by Fidriyanto R on 15/08/21.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var data = GameDetailResponse(gameId: 0, description: "", publishers: [], metacritic: 0)
    @Published var isLoading = false
    @Published var isFavorite = false

    let service: ServiceProtocol
    private lazy var favoriteProvider: FavoriteProvider = { return FavoriteProvider() }()
    init(service: ServiceProtocol = ApiService(), id: Int) {
        self.service = service
        getFavoriteState(id: id)
    }
    func getFavoriteState(id: Int) {
        favoriteProvider.getFavoriteState(id) { result in
            DispatchQueue.main.async {
                if result {
                    self.isFavorite = result
                    self.getFavorite(id: id)
                }
            }
        }
    }
    func addFavorite(favorite: FavoriteModel) -> Bool {
        do {
            try favoriteProvider.addFavorite(favorite)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }

    func deleteFavorite(id: Int) -> Bool {
        do {
            try favoriteProvider.deleteFavorite(id)
            return true
        } catch {
            print(error.localizedDescription)
        }
        return false
    }

    func getFavorite(id: Int) {
        favoriteProvider.getFavoriteGameById(id) { result in
            DispatchQueue.main.async {
                let publisher = result?.publishers?.split(separator: ",").map({ name in
                    PublisherResponse(id: Int.random(in: 0...100), name: String(name))
                })
                let gameDetail = GameDetailResponse(
                    gameId: Int(result?.id ?? 0),
                    description: result?.description ?? "",
                    publishers: publisher ?? [],
                    metacritic: result?.metacritic ?? 0
                )
                self.data = gameDetail
            }
        }
    }

    func loadGameDetailById(gameId: Int) {
        self.isLoading = true

        service.fetchGameDetailById(gameId: gameId, completion: { gameDetail in
            self.isLoading = false
            guard let gameDetail = gameDetail else {
                return
            }
            self.data = gameDetail
        })
    }
}
