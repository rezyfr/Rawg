//
//  GameDetailScreen.swift
//  Rawgames
//
//  Created by Fidriyanto R on 15/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailScreen: View {
    let game: GameResponse
    @State var isFavorited = false
    @ObservedObject var detailViewModel: DetailViewModel

    init(game: GameResponse) {
        self.game = game
        self.detailViewModel = DetailViewModel( id: game.id)
        UINavigationBar.appearance().backgroundColor = .black
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if detailViewModel.isLoading {
                VStack(alignment: .center) {
                    LoadingIndicator()
                }
            } else {
                if detailViewModel.data.id != 0 {
                    ScrollView {
                        VStack(alignment: .leading) {
                            WebImage(url: URL(string: game.backgroundImage), options: .highPriority, context: nil)
                                .resizable()
                                .frame(width: UIScreen.screenWidth, height: 230)
                                .aspectRatio(contentMode: .fill)
                            GeometryReader { geometry in
                                self.generateGenre(in: geometry, genres: game.genre)
                            }.padding(.bottom)
                            Group {
                                Text(game.name).font(.title).fontWeight(.black).foregroundColor(Color.white)

                                Text(game.rating
                                        .ratingMapper())
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 16)
                                if detailViewModel.data.id != 0 {
                                    about
                                    generateDetail(platforms: game.platforms)
                                }
                            }.padding(.horizontal, 12)
                        }
                    }
                } else {
                    EmptyView()
                }
            }
        }.onAppear {
            if detailViewModel.data.gameId == 0 {
                detailViewModel.loadGameDetailById(gameId: game.id)
            }
            isFavorited = self.detailViewModel.isFavorite
        }.navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(backgroundColor: .black, tintColor: .white)
        .navigationBarItems(trailing: favoriteButton)
    }

    var favoriteButton: some View {
        self.isFavorited ?
            Button(action: {
                self.isFavorited = !self.detailViewModel.deleteFavorite(id: game.id)
            }, label: {
                Image("icon_favorite_solid").imageScale(.large)
            })
            :
            Button(action: {
                let genres = game.genre.map({
                    $0.name
                }).joined(separator: ",")

                let platforms = game.platforms.map({
                    $0.platform.name
                }).joined(separator: ",")
                let publishers = detailViewModel.data.publishers.map({
                    $0.name
                }).joined(separator: ",")
                let favorite: FavoriteModel = FavoriteModel(
                    id: Int32(game.id),
                    name: game.name,
                    publishers: publishers,
                    releasedDate: game.releaseDate,
                    rating: Double(game.rating),
                    platforms: platforms,
                    backgroundImage: game.backgroundImage,
                    genres: genres,
                    description: detailViewModel.data.description,
                    metacritic: detailViewModel.data.metacritic
                )

                self.isFavorited = self.detailViewModel.addFavorite(favorite: favorite)
            }, label: {
                Image("icon_favorite").imageScale(.large)

            }
            )
    }

    var about: some View {
        VStack(alignment: .leading) {
            Text("About").font(.title3).foregroundColor(Color.white).padding(.bottom, 8)
            Text(detailViewModel.data.description).font(.body).foregroundColor(.white).padding(.bottom, 8)
        }
    }

    private func generateDetail(platforms: [PlatformsResponse]) -> some View {
        var platformName = ""
        platforms.forEach({platform in
            platformName.append("\(platform.platform.name), ")
        })
        var publisherNames = ""
        detailViewModel.data.publishers.forEach({publisher in
            publisherNames.append("\(publisher.name), ")
        })
        return HStack(alignment: .top, spacing: 4) {
            VStack(alignment: .leading) {
                Text("Platforms")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 4)
                Text(platformName).font(.body).foregroundColor(Color.white).padding(.bottom, 8)
                Text("Publisher")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 4)
                Text(publisherNames).font(.body).foregroundColor(Color.white).padding(.bottom, 8)
            }.frame(minWidth: 0, maxWidth: .infinity)
            VStack(alignment: .leading) {
                Text("Metascore").font(.headline).fontWeight(.bold).foregroundColor(Color.gray).padding(.bottom, 8)
                metacritic.padding(.bottom, 8)
                Text("Release Date").font(.headline).fontWeight(.bold).foregroundColor(Color.gray).padding(.bottom, 8)
                Text(game.releaseDate).font(.body).foregroundColor(Color.white).padding(.bottom, 8)
            }.frame(minWidth: 0, maxWidth: .infinity)
        }
    }

    var metacritic: some View {
        let score = detailViewModel.data.metacritic
        let fontColor = metacriticColor(score: score)
        return Text("\(score)")
            .font(.body)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundColor(fontColor)
            .padding(8)
            .background(
                RoundedRectangle(
                    cornerRadius: 8.0
                ).strokeBorder(fontColor))
    }

    private func generateGenre(in geo: GeometryProxy, genres: [GenreResponse]) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(genres, id: \.genreId) { genre in
                self.genreItem(for: genre.name)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { guide in
                        if abs(width - guide.width) > geo.size.width {
                            width = 0
                            height -= guide.height
                        }
                        let result = width
                        if genre.name == genres.last!.name {
                            width = 0 // last item
                        } else {
                            width -= guide.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {_ in
                        let result = height
                        if genre.name == genres.last!.name {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func genreItem(for text: String) -> some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .foregroundColor(.white)
    }

    private func metacriticColor(score: Int) -> Color {
        switch score {
        case 80..<101:
            return Color.green.opacity(0.8)
        case 70..<80:
            return Color.green
        case 55..<70:
            return Color.yellow
        case 0..<55:
            return Color.red
        default:
            return Color.green
        }
    }
}
