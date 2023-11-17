import SwiftUI

struct CardView: View {
    let card: SetGameViewModel.Card
    var faceUp = true
    @State private var isJumping = false
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            let background = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            background.fill(Color.white)
            Group {
                if card.matched {
                    shape.stroke(lineWidth: 3).fill(Color.mint).opacity(1)

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
        }
        .padding(3)
        .transition(.slide)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
    }
}
