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
                        .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                        .animation(.easeInOut(duration: 2), value: card.isMatched)
                )
        }
        .cardify(isFaceUp: card.isFaceUp)
        .opacity(card.isFaceUp || !card.matched ? 1 : 0)
}

