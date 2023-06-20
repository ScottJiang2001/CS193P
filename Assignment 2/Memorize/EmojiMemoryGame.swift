//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Scott Jiang on 2023-05-05.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    private(set) var theme: Theme
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let selectedEmojis = theme.emojiArr.shuffled()
        
        return MemoryGame<String>(numberOfPairsOfCards: 5, createCardContent: { pairIndex in
            selectedEmojis[pairIndex]
        })
    }
    
    init() {
        if let selectedTheme = themes.randomElement() {
            self.theme = selectedTheme
            self.model = EmojiMemoryGame.createMemoryGame(theme: selectedTheme)
        } else {
            fatalError()
            //crash the app if there are no themes (empty theme array)
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        let prevTheme = self.theme
        var newTheme = themes.randomElement()!
        
        while (prevTheme.name == newTheme.name) {
            newTheme = themes.randomElement()!
        } //This prevents same theme from being randomly selected
        
        self.theme = newTheme
        self.model = EmojiMemoryGame.createMemoryGame(theme: newTheme)
    }
    
}
