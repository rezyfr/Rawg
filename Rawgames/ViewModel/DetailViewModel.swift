//
//  DetailViewModel.swift
//  Rawgames
//
//  Created by Fidriyanto R on 15/08/21.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var data = GameDetail(id: 0, description: "", publishers: [], metacritic: 0)
    @Published var isLoading = false
    let service: ServiceProtocol

    init(service: ServiceProtocol = ApiService()) {
        self.service = service
    }

    func loadGameDetailById(gameId: String) {
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
