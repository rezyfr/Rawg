//
//  GameRow.swift
//  Rawgames
//
//  Created by Fidriyanto R on 14/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRow: View {
    var game: GameResponse
    var body: some View {
        ZStack(alignment: Alignment.topLeading) {
            WebImage(url: URL(string: game.backgroundImage), options: .highPriority, context: nil)
                .resizable()
                .scaledToFit()
                .cornerRadius(16)
                .overlay(
                    ZStack(alignment: .bottomLeading) {
                        Color.black.opacity(0.2)
                        VStack(alignment: .leading, spacing: 0) {
                            LazyHStack {
                                ForEach(game.platforms.prefix(3), id: \.platform.name) { platform in
                                    PlatformView(platform: platform)
                                }
                            }.frame(height: 20).padding(.leading, 6).padding(.bottom, 4)
                            Text(game.name)
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding(.leading, 12)
                                .padding(.bottom, 8)
                        }
                    }.cornerRadius(16).frame(maxWidth: .infinity)
                )
            HStack {
                Spacer()
                VStack {
                    Text("\(game.rating.forTrailingZero())")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 25.0
                            ).strokeBorder(Color.white).background(
                                RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/)
                                    .fill(Color.black.opacity(0.25))))

                }.padding(.top, 6).padding(.trailing, 6)
            }

        }.listRowBackground(Color.black).padding(.horizontal, 8).padding(.bottom, 16)
    }
}

struct PlatformView: View {
    var platform: PlatformsResponse
    var body: some View {
        Text(platform.platform.name.platformMapper())
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color.black.opacity(0.5))
            )
    }
}

extension String {
    func platformMapper() -> String {
        switch self {
        case "PlayStation 3":
            return "PS3"

        case "PlayStation 4":
            return "PS4"

        case "PlayStation 5":
            return "PS5"
        case "Nintendo Switch":
            return "Switch"
        default:
            return self
        }
    }
}

extension Double {
    func forTrailingZero() -> String {
        let tempVar = String(format: "%g", self)
        return tempVar
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: GameResponse(idGame: 1, name: "GTA 5", releaseDate: "2021-04-12", rating: 4.48, platforms: [
            PlatformsResponse(platform: PlatformResponse(name: "PS5")),
            PlatformsResponse(platform: PlatformResponse(name: "PC") ),
            PlatformsResponse(platform: PlatformResponse(name: "Xbox One"))
        ], backgroundImage: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507807a1808595afb12.jpg",
        genre: [GenreResponse(genreId: 1, name: "Action")]))
    }
}
