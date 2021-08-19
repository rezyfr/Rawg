//
//  FavoriteViewModel.swift
//  Rawgames
//
//  Created by Fidriyanto R on 20/08/21.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var data = [FavoriteModel]()
    private lazy var favoriteProvider: FavoriteProvider = { return FavoriteProvider() }()

    func loadFavoriteList() {
        favoriteProvider.getFavoriteGames { result in
            DispatchQueue.main.async {
                self.data = result
            }
        }
    }
}
