// ContentView.swift
// The Appraiser — Root Navigation Controller

import SwiftUI

struct ContentView: View {
    @State private var game = GameManager()

    var body: some View {
        Group {
            switch game.currentScreen {
            case .mainMenu:
                MainMenuView()

            case .levelSelect:
                LevelSelectView()

            case .gameplay(let artCase):
                GameplayView(artCase: artCase)

            case .results(let result):
                ResultsView(result: result)
            }
        }
        .environment(game)
        .animation(.easeInOut(duration: 0.3), value: screenID)
    }

    /// A stable string key for the current screen — drives the cross-fade transition.
    private var screenID: String {
        switch game.currentScreen {
        case .mainMenu:            return "menu"
        case .levelSelect:         return "levels"
        case .gameplay(let c):     return "game-\(c.id)"
        case .results(let r):      return "results-\(r.levelID)"
        }
    }
}

#Preview {
    ContentView()
}
