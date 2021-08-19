//
//  FavoriteScreen.swift
//  Rawgames
//
//  Created by Fidriyanto R on 19/08/21.
//

import Foundation
import SwiftUI

struct FavoriteScreen: View {

    @ObservedObject var favoriteViewModel =  FavoriteViewModel()
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    Text("Favorite Games")
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .tracking(5)
                }
                if !favoriteViewModel.data.isEmpty {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            let game: [GameResponse] = favoriteViewModel.data.map({ favorite in
                                let platforms: [PlatformsResponse] = favorite.platforms?.split(separator: ",")
                                    .map({ name in
                                    PlatformsResponse(platform: PlatformResponse(name: String(name)))
                                }) ?? []
                                let genres: [GenreResponse] = favorite.genres?.split(separator: ",").map({ name in
                                    GenreResponse(genreId: Int.random(in: 0...100), name: String(name))
                                }) ?? []
                                return GameResponse(
                                    idGame: Int(favorite.id ?? 0),
                                    name: favorite.name ?? "",
                                    releaseDate: favorite.releasedDate ?? "",
                                    rating: favorite.rating ?? 0,
                                    platforms: platforms,
                                    backgroundImage: favorite.backgroundImage ?? "",
                                    genre: genres
                                )
                            })
                            ForEach(game) { game in
                                NavigationLink(destination: GameDetailScreen( game: game)) {
                                    GameRow(game: game).listRowInsets(EdgeInsets())
                                }.listRowBackground(Color.black).listRowInsets(EdgeInsets())
                            }
                        }
                    }
                } else {
                    EmptyView()
                }
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
        .onAppear {
            self.favoriteViewModel.loadFavoriteList()
        }
    }
}
