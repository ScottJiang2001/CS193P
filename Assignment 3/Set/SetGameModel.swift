//
//  SetGameModel.swift
//  Set
//
//  Created by Scott Jiang on 2023-06-24.
//

import Foundation
import SwiftUI

struct SetGameModel<CardContent> {
    private(set) var cards: Array<Card>
    
    let shapes = ["rectangle", "diamond", "circle"]
    let opacities = [0, 0.5, 1]
    let colours = [Color.green, Color.blue, Color.red]
    
    
    init() {
        cards = []
        var idNum = 0
        
        for shape in shapes {
            for colour in colours {
                for opacity in opacities {
                    for num in 1...3 {
                        cards.append(Card(id: idNum, shape: shape, opacity: opacity, colour: colour, number: num))
                        idNum += 1
                    }
                }
            }
        }
        
        cards.shuffle()
    }
    
    
    struct Card: Identifiable{
        let id: Int
        let shape: String
        let opacity: CGFloat
        let colour: Color
        let number: Int
    }
    
}
