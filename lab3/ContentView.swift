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
                        viewModel.choose(card)
                    }
            }
        }
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
