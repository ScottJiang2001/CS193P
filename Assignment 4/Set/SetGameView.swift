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
                discardedCards.padding(20)
                Spacer()
                Button("Start New Game") {
                    setGame.startNewGame()
                }
                Spacer()
                undealtCards.padding(20)
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
                        withAnimation {
                            setGame.choose(card)
                        }
                    }
            })
            .padding([.top, .leading, .trailing], 25.0)
        }
    }
    
    @Namespace private var dealingNamespace
    
    private func zIndex(of card: SetGameViewModel.Card) -> Double {
        -Double(setGame.allCards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private func dealAnimation(for card: SetGameViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = setGame.playingCards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(setGame.playingCards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    var discardedCards: some View {
        ZStack {
            Text("Matched Cards")
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1).opacity(1)
                        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
                )
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let setGame = SetGameViewModel()
        SetGameView(setGame: setGame)
    }
}
