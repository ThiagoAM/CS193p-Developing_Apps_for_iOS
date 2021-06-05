//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Thiago Martins on 11/04/21.
//
//  ViewModel

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model:
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s):
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}
