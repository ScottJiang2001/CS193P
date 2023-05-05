//
//  ContentView.swift
//  Memorize
//
//  Created by Scott Jiang on 2023-05-01.
//

import SwiftUI

//public var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚚"]


struct ContentView: View {
    
    @State var vehicles = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚚"]
    @State var regular = ["😀", "😂", "😍", "🤔", "🤯", "🥺", "🙄", "😴", "🤢", "🤗"]
    @State var food = ["🍔", "🍕", "🍟", "🍗", "🌮", "🥪", "🍣", "🍩", "🍦", "🍰"]

    @State var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚚"]
    
    @State var emojiCount = 10
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3,contentMode: .fit)
                    }
                }
            }
            .foregroundColor(Color.red)
            Spacer()
            HStack {
                ButtonView(emojiArray: vehicles, contentView: self, image: "car", description: "Vehicles")
                Spacer()
                ButtonView(emojiArray: regular, contentView: self, image: "face.smiling", description: "Regular")
                Spacer()
                ButtonView(emojiArray: food, contentView: self, image: "fork.knife", description: "Food")
            }
            .padding(.horizontal, 25.0)
        }
    }
    
    struct ButtonView: View {
        @State var emojiArray: [String]
        var contentView: ContentView
        var image: String
        var description: String

        var body: some View {
            Button(action: {
                emojiArray.shuffle()
                contentView.emojis = emojiArray
            }, label: {
                VStack {
                    Image(systemName: image)
                        .font(.largeTitle)
                    Text(description)
                }
            })
        }
    }
}

struct CardView: View {
    var content: String
   @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 15.0)
            
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
