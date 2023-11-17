//
//  SetApp.swift
//  Set
//
//  Created by Scott Jiang on 2023-06-22.
//

import SwiftUI

@main
struct SetApp: App {
    private let setGame = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView(setGame: setGame)
        }
    }
}
