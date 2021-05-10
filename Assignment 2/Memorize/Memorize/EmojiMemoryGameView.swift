//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Thiago Martins on 11/04/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            titleLabel
            scoreLabel
            cardsGrid
            newGameButton
        }
    }
    
    // MARK: - Views:
    
    private var titleLabel: some View {
        Text(viewModel.theme.name)
            .font(.title)
    }
    
    private var scoreLabel: some View {
        Text("Score: \(viewModel.score)")
    }
    
    private var cardsGrid: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card, color: viewModel.theme.color, gradient: viewModel.theme.gradient).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()        
    }
    
    private var newGameButton: some View {
        Button("New Game") {
            viewModel.didTouchNewGameButton()
        }
        .foregroundColor(.blue)
    }
    
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    private var color: Color?
    private var gradient: Gradient?
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    init(card: MemoryGame<String>.Card, color: Color?, gradient: Gradient?) {
        self.card = card
        self.color = color
        self.gradient = gradient
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    if let color = color {
                        RoundedRectangle(cornerRadius: cornerRadius).fill(color)
                    } else if let gradient = gradient {
                        RoundedRectangle(cornerRadius: cornerRadius).fill(
                            LinearGradient(
                                gradient: gradient,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    }
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants:
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    
}























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
