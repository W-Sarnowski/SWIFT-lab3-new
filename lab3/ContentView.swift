import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MemoGameViewModel = MemoGameViewModel()

    var body: some View {
        VStack {
            Text("Memo")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            ScrollView {
                cardDisplay
                    .animation(.default, value: viewModel.cards)
            }

            HStack {
                Text("Score: \(viewModel.score)")
                Spacer()
            }
            
            Button("🔀") {
                withAnimation {
                    viewModel.shuffle()
                }
            }
            .padding()
            
            themeButtons
        }
        .foregroundColor(MemoGameViewModel.color)
        .padding()
    }
    
    var cardDisplay: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))], spacing: 10) {
            ForEach (viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        withAnimation() {
                            let scoreBeforeChoosing = viewModel.score
                            viewModel.choose(card)
                            let scoreChange = viewModel.score - scoreBeforeChoosing
                            lastScoreChange = (scoreChange, causedByCardId: card.id)
                        }
                    }
            }
        }
    }

    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    var themeButtons: some View {
        return themeButtonsViews()
    }
    
    func themeButtonsViews() -> some View {
        HStack {
            ThemeButtonView(number: 1, image: "note", viewModel: viewModel)
            Spacer()
            ThemeButtonView(number: 2, image: "heart", viewModel: viewModel)
            Spacer()
            ThemeButtonView(number: 3, image: "doc", viewModel: viewModel)
        }
    }
}
