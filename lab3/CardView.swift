import SwiftUI

struct CardView: View {
    var card: MemoGameModel<String>.Card
    
    init(_ card: MemoGameModel<String>.Card) {
        self.card = card
    }
    
    var body: some View {
            CirclePart(endAngle: .degrees(240))
                .opacity(0.3)
                .overlay(
                    Text(card.content)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(contentMode: .fit)
                )
        }
        .modifier(Cardify(isFaceUp: card.isFaceUp))
        .opacity(card.faceUp || !card.matched ? 1 : 0)
}

