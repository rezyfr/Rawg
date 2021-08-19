//
//  HomeViewModel.swift
//  Rawgames
//
//  Created by Fidriyanto R on 14/08/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var data = GamesResponse(results: [])
    @Published var isLoading = false

    let service: ServiceProtocol
    init(service: ServiceProtocol = ApiService()) {
        self.service = service
    }
    func loadGameList() {
        self.isLoading = true
        service.fetchGameList(completion: { gameList in
            self.isLoading = false
            guard let games = gameList else {
                return
            }
            self.data.results = games
        })
    }
}
