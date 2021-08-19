//
//  GameList.swift
//  Rawgames
//
//  Created by Fidriyanto R on 14/08/21.
//

import SwiftUI

struct GameList: View {

    @ObservedObject var homeViewModel =  HomeViewModel()
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    Text("RAWG")
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .tracking(5)
                    Spacer()
                    NavigationLink(destination: ProfileView()) {
                        Image("profile")
                    }
                }

                if homeViewModel.isLoading {ZStack {
                    Color.black.ignoresSafeArea()
                    VStack(alignment: .center) {
                        Color.black.ignoresSafeArea()
                        LoadingIndicator()
                    }}
                } else {
                    if !homeViewModel.data.results.isEmpty {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack {
                                ForEach(homeViewModel.data.results) { game in
                                    NavigationLink(destination: GameDetailScreen( game: game)) {
                                        GameRow(game: game).listRowInsets(EdgeInsets())
                                    }.listRowBackground(Color.black).listRowInsets(EdgeInsets())
                                }
                            }
                        }
                    } else {
                        EmptyView()
                    }
                }
            }.padding()
        }.navigationBarHidden(true)
        .onAppear {
            self.homeViewModel.loadGameList()
        }
    }

    struct GameList_Previews: PreviewProvider {
        static var previews: some View {
            GameList()
        }
    }
}
