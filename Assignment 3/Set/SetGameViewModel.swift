//
//  SetGameViewModel.swift
//  Set
//
//  Created by Scott Jiang on 2023-06-24.
//

import Foundation

class SetGameViewModel: ObservableObject {
    
    private static func createSetGame() -> SetGameModel<String> {
        SetGameModel<String>()
    }
    
    @Published private var model = createSetGame()
    
    var allCards: Array<SetGameModel<String>.Card> {
        return model.allCards
    }
    
    var playingCards: Array<SetGameModel<String>.Card> {
        return model.playingCards
    }
    
    func choose(_ card: SetGameModel<String>.Card) {
        model.choose(card)
    }
    
    func addCards() {
        model.addCards()
    }
    
    func startNewGame() {
        model = SetGameViewModel.createSetGame()
    }
}
