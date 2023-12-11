import SwiftUI

class MemoGameViewModel: ObservableObject {
    static var content1 = ["😁", "🥰", "💩", "😰", "🤬"]
    static var content2 = ["🕸️","🧙‍♀️","🙀","👹","😱"]
    static var content3 = ["😇", "🥹", "🥶", "🤐", "🕷️"]
    public static var content = content1
    public static var color = Color.blue
    
    static func createModel() -> MemoGameModel<String> {
        return MemoGameModel<String>(numberOfPairsOfCards: content.count) { index in
            if (content.indices.contains(index)) {
                return content[index]
            } else {
                return "?"
            }
        }
    }
    
    @Published var model = createModel()
    
    var cards: Array<MemoGameModel<String>.Card> {
        return model.cards
    }

    var score: Int {
        return model.score
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoGameModel<String>.Card) {
        model.choose(card)
    }
    
    func theme(theme: Int) {
        if (theme == 1) {
            MemoGameViewModel.content = MemoGameViewModel.content1
            MemoGameViewModel.color = Color.blue
        } else if (theme == 2) {
            MemoGameViewModel.content = MemoGameViewModel.content2
            MemoGameViewModel.color = Color.red
        } else {
            MemoGameViewModel.content = MemoGameViewModel.content3
            MemoGameViewModel.color = Color.green
        }
        
        model = MemoGameViewModel.createModel()
    }
}
