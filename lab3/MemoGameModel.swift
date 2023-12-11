import Foundation

struct MemoGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pair in 0 ..< max(2, numberOfPairsOfCards) {
            let cardContent = cardContentFactory(pair)
            cards.append(Card(content: cardContent, id: "\(pair + 1)a"))
            cards.append(Card(content: cardContent, id: "\(pair + 1)b"))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCards = cards.indices.filter { index in
                cards[index].isFaceUp
            }
            return faceUpCards.count == 1 ? faceUpCards.first : nil
        }
        set {
            return cards.indices.forEach {
                cards[$0].isFaceUp = (newValue == $0)
            }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if (!cards[chosenIndex].isFaceUp && !cards[chosenIndex].matched) {
                if let potentialIndex = indexOfOneAndOnlyFaceUpCard {
                    if (cards[chosenIndex].content == cards[potentialIndex].content) {
                        cards[chosenIndex].matched = true
                        cards[potentialIndex].matched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable {
        /*static func == (lhs: MemoGameModel<CardContent>.Card, rhs: MemoGameModel<CardContent>.Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
        }*/
    
        var isFaceUp = false { 
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var matched = false

        var hasBeenSeen = false

        var content: CardContent
        var id: String
    }
}
