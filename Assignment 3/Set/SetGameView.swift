//
//  ContentView.swift
//  Set
//
//  Created by Scott Jiang on 2023-06-22.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var setGame: SetGameViewModel
    
    var body: some View {
        AspectVGrid(items: setGame.cards, aspectRatio: 2/3, content: {card in
                CardView(shapeColor: card.colour, numShape: card.number, cardShape: card.shape, cardOpacity: card.opacity)
            })
            .padding(2)
    }
}

struct CardView: View {
    var shapeColor: Color
    var numShape: Int
    var cardShape: String
    var cardOpacity: CGFloat
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            shape.stroke(lineWidth: 1).fill(shapeColor)
            VStack {
                ForEach(0..<numShape, id: \.self) { num in
                    ZStack {
                        if cardShape == "rectangle" {
                            Rectangle()
                                .fill(shapeColor)
                                .opacity(cardOpacity)
                            Rectangle()
                                .stroke(shapeColor, lineWidth: 1)
                        } else if cardShape == "diamond" {
                            Diamond()
                                .fill(shapeColor)
                                .opacity(cardOpacity)
                            Diamond()
                                .stroke(shapeColor, lineWidth: 1)
                        } else {
                            Circle()
                                .fill(shapeColor)
                                .opacity(cardOpacity)
                            Circle()
                                .stroke(shapeColor, lineWidth: 1)
                        }
                    }.aspectRatio(2, contentMode: .fit)
                }
            }
        }.padding(2)
    }
    
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let setGame = SetGameViewModel()
        SetGameView(setGame: setGame)
    }
}
