//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Scott Jiang on 2023-05-05.
//

import SwiftUI


class EmojiMemoryGame {
    
    static let emojis = ["😀", "😂", "😍", "🤔", "🥺", "🚀", "🌈", "🍕", "🐶", "🐱", "🌸", "🍩", "🎉", "🎸", "🎨", "🏀", "🚲", "🏔", "🌊", "🍁", "🍓", "🍔", "🍟", "🍺", "🍷", "🌙", "⛅️", "🌪", "🔥", "💩"]
    
    static func createMemoryGame() -> MemoryGame<String> {
            MemoryGame<String>(numberOfPairsOfCards: 4, createCardContent: { pairIndex in
            emojis[pairIndex]
        })
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}