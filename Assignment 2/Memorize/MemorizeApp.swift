//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Scott Jiang on 2023-05-01.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
