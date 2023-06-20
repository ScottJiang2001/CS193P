//
//  MemoryGame.swift
//  Memorize
//
//  Created by Scott Jiang on 2023-05-05.
//

import Foundation

// Making MemoryGame A "don't care" so we can choose what to use on our card like an image OR String

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfOnlyFaceUpCard: Int?
    private(set) var score = 0 //private(set) allows this property to be read from anywhere but only modified or set by the current file or class
    private var cardSet: Set<Int> = []
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isFaceUp = true // cards that are matched should stay face up
                    cards[potentialMatchIndex].isFaceUp = true
                    score += 2
                } else if (cardSet.contains(chosenIndex)) {
                    score -= 1
                }
                indexOfOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    if !cards[index].isMatched {
                        cards[index].isFaceUp = false
                    }
                }
                indexOfOnlyFaceUpCard = chosenIndex
            }
            if !cards[chosenIndex].isMatched {
                cards[chosenIndex].isFaceUp.toggle()
            }
            cardSet.insert(chosenIndex)
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
    }
        
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
