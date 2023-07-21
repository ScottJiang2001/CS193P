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
        VStack {
            Text("Set Game").font(.system(size: 30))
            AspectVGrid(items: setGame.playingCards, aspectRatio: 2/3, content: {card in
                CardView(shapeColor: card.colour, numShape: card.number, cardShape: card.shape, cardOpacity: card.opacity, selected: card.selected, matched: card.matched, notMatched: card.notMatched)
                    .onTapGesture {
                        print("clicked")
                        setGame.choose(card)
                    }
            })
            .padding([.top, .leading, .trailing], 25.0)
            VStack {
                Button("Add 3 More Cards") {
                    withAnimation {
                        setGame.addCards()
                    }
                }.buttonStyle(.bordered)
                    .controlSize(.large)
                    .font(.system(size:20))
                    .padding(.vertical, 10.0)
                    .disabled(setGame.allCards.count == 0)
                Button("Start New Game") {
                    setGame.startNewGame()
                }
            }
        }
    }
    
    @State private var dealt = Set<Int>()
    
}

struct CardView: View {
    var shapeColor: Color
    var numShape: Int
    var cardShape: String
    var cardOpacity: CGFloat
    var selected: Bool
    var matched: Bool
    var notMatched: Bool
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if matched {
                shape.stroke(lineWidth: 3).fill(Color.mint)
            } else if notMatched {
                shape.stroke(lineWidth: 3).fill(Color.orange)
            }
            else if selected {
                ZStack {
                    shape.fill(Color.yellow).opacity(0.4)
                    shape.stroke(lineWidth: 1)
                }
            } else {
                shape.stroke(lineWidth: 1)
            }
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
                    }.aspectRatio(2, contentMode: .fit).padding(.horizontal, 10.0)
                }
            }
        }.padding(3)
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
