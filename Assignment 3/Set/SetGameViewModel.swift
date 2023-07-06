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
    
    var cards: Array<SetGameModel<String>.Card> {
        return model.cards
    }
    
}
