//
//  ContentView.swift
//  Memorize
//
//  Created by Scott Jiang on 2023-05-01.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["😀", "😂", "😍", "🤔", "🥺", "🚀", "🌈", "🍕", "🐶", "🐱", "🌸", "🍩", "🎉", "🎸", "🎨", "🏀", "🚲", "🏔", "🌊", "🍁", "🍓", "🍔", "🍟", "🍺", "🍷", "🌙", "⛅️", "🌪", "🔥", "💩"]
    @State var emojiCount = 20
    
    var body: some View {
        VStack {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3,contentMode: .fit)
                    }
                }
            }
            .foregroundColor(Color.red)
            .font(.largeTitle)
            .padding(.horizontal, 25.0)
        }
    }
}

struct CardView: View {
    var content: String
   @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            
            if isFaceUp {
                shape.stroke(lineWidth: 5).foregroundColor(.red)
                shape.fill(Color.white)
                Text(content)
                    .font(.largeTitle)
            }
            else {
                shape.fill(Color.red)
            }
        }
        .padding(.horizontal, 2.0)
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
