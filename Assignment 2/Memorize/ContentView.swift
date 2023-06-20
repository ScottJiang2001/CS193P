//
//  ContentView.swift
//  Memorize
//
//  Created by Scott Jiang on 2023-05-01.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                Labels(themeName: viewModel.theme.name, score: viewModel.score)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3,contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
            NewGameButton(model: viewModel)
        }
        .foregroundColor(viewModel.theme.color)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            
            if card.isFaceUp {
                shape.stroke(lineWidth: 5)
                shape.fill(Color.white)
                Text(card.content)
                    .font(.largeTitle)
                    .padding()
            }
            else {
                shape.stroke(lineWidth: 5)
                shape.fill(Color.gray)
            }
        }
        .padding(.horizontal, 2.0)
    }
}

struct Labels: View {
    var themeName: String
    let score: Int;
    
    var body: some View {
        VStack {
            Text(themeName).font(.system(size: 40))
            Text("Score: \(score) ").font(.system(size: 33))
        }
    }
}

struct NewGameButton: View {
    var model: EmojiMemoryGame
    
    var body: some View {
        Button(action: model.startNewGame) {
            Text("Start New Game")
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
        .font(.system(size:35))
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
