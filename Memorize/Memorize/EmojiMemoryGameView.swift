//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Scott Jiang on 2023-05-01.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: {card in
            cardView(for: card)
            })
        .foregroundColor(Color.red)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }
    
    //ViewBuilder can be used in arguments or above a func to indicate that a View is being built
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
    
                if card.isFaceUp {
                    shape.stroke(lineWidth: DrawingConstants.lineWidth).foregroundColor(.red)
                    shape.fill(Color.white)
                    //Circle().padding(5).opacity(0.5)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 115-90)).padding(5).opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.stroke(lineWidth: 3).foregroundColor(.red)
                    shape.fill(Color.red)
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.70
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
        //        EmojiMemoryGameView(game: game)
        //            .preferredColorScheme(.dark)
        //        EmojiMemoryGameView(game: game)
        //            .preferredColorScheme(.light)
        //    }
    }
}
