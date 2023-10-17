import SwiftUI

struct ContentView: View {
    let contents: Array<String> = ["😁", "😢", "🥰", "🥰", "💩", "💀", "😰", "🤯", "🤬", "😇"]
    @State var cardCount = 10
    let off = 2

    var body: some View {
        VStack {
            Text("Memo")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            ScrollView {
                cardDisplay
            }
            
            themeButtons
            
            /*
            HStack {
                addCard
                Spacer()
                removeCard
            }
            */
        }
        .padding()
    }
    
    var cardDisplay: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach (0 ..< cardCount, id: \.self) { index in
                CardView(faceUp: false, content: contents[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.blue)
    }
    
    var themeButtons: some View {
        return themeButtonsViews()
    }
    
    func themeButtonsViews() -> some View {
        HStack {
            ThemeButtonView(number: 1, image: "note")
            Spacer()
            ThemeButtonView(number: 2, image: "heart")
            Spacer()
            ThemeButtonView(number: 3, image: "doc")
        }
    }
    
    /*
    var addCard: some View {
        return adjustCardNumber(offset: off, symbol: "+")
    }
    
    var removeCard: some View {
        return adjustCardNumber(offset: off, symbol: "-")
    }
    
    func adjustCardNumber(offset: Int, symbol: String) -> some View {
        Button(symbol) {
            if (symbol == "+") {
                cardCount = cardCount + offset
            }
            else if (symbol == "-") {
                cardCount = cardCount - offset
            }
        }
        .disabled(symbol == "+" ? (cardCount + off > contents.count ? true : false) : (cardCount - off <= 0 ? true : false))
    }
    */
}
