//
//  SetGameModel.swift
//  Set
//
//  Created by Scott Jiang on 2023-06-24.
//

import Foundation
import SwiftUI

struct SetGameModel<CardContent> {
    private(set) var allCards: Array<Card>
    var playingCards: Array<Card>
    
    let shapes = ["rectangle", "diamond", "circle"]
    let opacities = [0, 0.4, 1]
    let colours = [Color.green, Color.blue, Color.red]

    
    mutating func addCards() {
        var i = 0
        
        let matchedCards = playingCards.filter {$0.matched}
        
        if matchedCards.count == 3 {
            matchedCards.forEach { card in
                if let matchedIndex = playingCards.firstIndex(where: {$0.id == card.id}) {
                    let temp = allCards.removeFirst()
                    playingCards.remove(at: matchedIndex)
                    playingCards.insert(temp, at: matchedIndex)
                    
                }
            }
        }
        else {
            while i < 3 && !allCards.isEmpty {
                let temp = allCards.removeFirst()
                playingCards.append(temp)
                i += 1
            }
        }
    }
    
    /*
     Conditions when selecting 3 cards
     
     when 3 cards selected are matching
     -> selecting the 4th card causes those 3 to be replaced or fully removed if no more cards remaining
     
     when a card is touched and there are already 3 NON-matching cards
     -> deselect the 3 cards and select the new card
     */
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id} ),
            !playingCards[chosenIndex].matched,
            !playingCards[chosenIndex].notMatched
        {
            playingCards[chosenIndex].selected.toggle()
            
            let selectedCards = playingCards.filter {$0.selected}
            if selectedCards.count == 4 {
                selectedCards.enumerated().forEach { (index,card) in
                    if let cardIndex = playingCards.firstIndex(where: {$0.id == card.id}) {
                        if playingCards[cardIndex].matched {
                            playingCards.remove(at: cardIndex)
                            
                            if !allCards.isEmpty {
                                let newCard = allCards.removeFirst()
                                playingCards.insert(newCard, at: cardIndex)
                            }
                        } else if playingCards[cardIndex].notMatched {
                            playingCards[cardIndex].selected.toggle()
                            playingCards[cardIndex].notMatched.toggle()
                        }
                    }
                    
                }
            }
            
        
            if selectedCards.count == 3 {
                if checkMatching(selectedCards) {
                    selectedCards.forEach { card in
                        if let matchedIndex = playingCards.firstIndex(where: { $0.id == card.id}) {
                            playingCards[matchedIndex].matched.toggle()
                        }
                    }
                } else {
                    selectedCards.forEach { card in
                        if let deselectIndex = playingCards.firstIndex(where: { $0.id == card.id} ) {
                            playingCards[deselectIndex].notMatched.toggle()
                        }
                    }
                }
            }
        }
    
    }
    
   
    private func checkMatching(_ selectedCards: Array<Card>) -> Bool {
        var attributes: [AnyHashable: Int] = [:]
        
        selectedCards.forEach { card in
            attributes[card.colour, default: 0] += 1
            attributes[card.opacity, default: 0] += 1
            attributes[card.number, default: 0] += 1
            attributes[card.shape, default: 0] += 1
        }
        
        for (_, count) in attributes {
            if count == 2 {
                return false
            }
        }
        
        return true
    }

    
    init() {
        allCards = []
        playingCards = []
        var idNum = 0
        
        for shape in shapes {
            for colour in colours {
                for opacity in opacities {
                    for num in 1...3 {
                        allCards.append(Card(id: idNum, shape: shape, opacity: opacity, colour: colour, number: num))
                        idNum += 1
                    }
                }
            }
        }
        
//        allCards.shuffle()
        
        for _ in 1...12 {
            let temp = allCards.removeFirst()
            playingCards.append(temp)
        }
    }
    
    
    struct Card: Identifiable {
        let id: Int
        let shape: String
        let opacity: CGFloat
        let colour: Color
        let number: Int
        
        var selected: Bool = false
        var matched: Bool = false
        var notMatched: Bool = false
    }
    
}
