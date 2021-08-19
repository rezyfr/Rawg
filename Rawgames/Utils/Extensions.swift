//
//  Extensions.swift
//  Rawgames
//
//  Created by Fidriyanto R on 16/08/21.
//
import SwiftUI

extension View {
    func navigationBarColor(backgroundColor: UIColor, tintColor: UIColor) -> some View {
        self.modifier(NavigationBarColor(backgroundColor: backgroundColor, tintColor: tintColor))
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

extension Double {
    func ratingMapper() -> String {
        switch self {
        case 4.5..<5.0:
            return "Exceptional 🎯"
        case 3.75..<4.5:
            return "Recommended 👍"
        case 3.0..<3.75:
            return "Meh 😑"
        case 0..<3.0:
            return "Skip ⛔"
        default:
            return "Recommended 👍"
        }
    }
}
