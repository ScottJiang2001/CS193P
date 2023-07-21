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
            gameBody
            HStack {
                discardedCards
                Spacer()
                Button("Start New Game") {
                    setGame.startNewGame()
                }
                Spacer()
                undealtCards
            }
        }
    }
    
    var gameBody: some View {
        VStack {
            Text("Set Game").font(.system(size: 30))
            AspectVGrid(items: setGame.playingCards, aspectRatio: 2/3, content: {card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .onTapGesture {
                        print("clicked")
                        withAnimation {
                            setGame.choose(card)
                        }
                    }
            })
            .padding([.top, .leading, .trailing], 25.0)
//            VStack {
////                Button("Add 3 More Cards") {
////                    withAnimation {
////                        setGame.addCards()
////                    }
////                }.buttonStyle(.bordered)
////                    .controlSize(.large)
////                    .font(.system(size:20))
////                    .padding(.vertical, 10.0)
////                    .disabled(setGame.allCards.count == 0)
//            }
        }
    }
    
    @Namespace private var dealingNamespace
    
    private func zIndex(of card: SetGameViewModel.Card) -> Double {
        -Double(setGame.allCards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var discardedCards: some View {
        ZStack {
            ForEach(setGame.discardedCards) { card in
                CardView(card: card)
                    .zIndex(zIndex(of: card))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
    }
    
    var undealtCards: some View {
        ZStack {
            ForEach(setGame.allCards) { card in
                CardView(card: card, faceUp: false)
                    .zIndex(zIndex(of: card))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .onTapGesture {
            print("clicked")
            withAnimation {
                setGame.addCards()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat =  undealtHeight * aspectRatio
    }
}

struct CardView: View {
    let card: SetGameViewModel.Card
    var faceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if card.matched {
                shape.stroke(lineWidth: 3).fill(Color.mint)
            } else if card.notMatched {
                shape.stroke(lineWidth: 3).fill(Color.orange)
            } else if card.selected {
                ZStack {
                    shape.fill(Color.yellow).opacity(0.4)
                    shape.stroke(lineWidth: 1)
                }
            } else {
                shape.stroke(lineWidth: 1).opacity(1)
            }
            if faceUp {
                VStack {
                    ForEach(0..<card.number, id: \.self) { num in
                        ZStack {
                            if card.shape == "rectangle" {
                                Rectangle()
                                    .fill(card.colour)
                                    .opacity(card.opacity)
                                Rectangle()
                                    .stroke(card.colour, lineWidth: 1)
                            } else if card.shape == "diamond" {
                                Diamond()
                                    .fill(card.colour)
                                    .opacity(card.opacity)
                                Diamond()
                                    .stroke(card.colour, lineWidth: 1)
                            } else {
                                Circle()
                                    .fill(card.colour)
                                    .opacity(card.opacity)
                                Circle()
                                    .stroke(card.colour, lineWidth: 1)
                            }
                        }.aspectRatio(2, contentMode: .fit).padding(.horizontal, 10.0)
                    }
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
