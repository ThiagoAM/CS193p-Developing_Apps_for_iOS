//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Thiago Martins on 11/04/21.
//
//  ViewModel

import Foundation

class EmojiMemoryGame {
    
    private var model = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷", "👽", "☠️", "👹", "👾", "💀", "👺", "🧜‍♂️", "😈", "🤡"].shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    var numberOfCards: Int { cards.count }
    
    // MARK: - Access to the Model:
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards.shuffled()
    }
    
    // MARK: - Intent(s):
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
