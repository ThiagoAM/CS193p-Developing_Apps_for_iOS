//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Thiago Martins on 11/04/21.
//
//  ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    public var theme: Theme {
        model.theme
    }
    
    public var score: Double {
        model.score
    }
    
    @Published private var model: MemoryGame<String>!
    
    private func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.contentSet
        var memoryGame = MemoryGame<String>(theme: theme, numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
        memoryGame.cards.shuffle()
        return memoryGame
    }
    
    init(theme: Theme? = nil) {
        self.model = createMemoryGame(theme: theme ?? EmojiMemoryGame.themes.randomElement()!)
    }
    
    // MARK: - Access to the Model:
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s):
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func beginNewGame() {
        model = createMemoryGame(theme: randomDifferentTheme)
    }
    
    // MARK: - Did Touch Events:
    
    func didTouchNewGameButton() {
        beginNewGame()
    }
    
    // MARK: - Private Computed Properties:
    private var randomDifferentTheme: Theme {
        let randomDifferentThemes = EmojiMemoryGame.themes.filter { $0.name != theme.name }
        return randomDifferentThemes.randomElement()!
    }
    
}

extension EmojiMemoryGame {
    
    typealias Theme = MemoryGame<String>.Theme
    
    static var themes: [Theme] {[
        Theme(name: "Halloween", contentSet: ["👻", "🎃", "🕷"], numberOfCards: 3, color: .orange),
        Theme(name: "Animals", contentSet: ["🐶", "🐻", "🐼", "🐷", "🐵"], numberOfCards: 5, color: .yellow),
        Theme(name: "Sports", contentSet: ["🏀", "⚽️", "⚾️", "🏈", "🏓"], numberOfCards: 5, color: .blue),
        Theme(name: "Faces", contentSet: ["😀", "😂", "😍", "😜", "😎", "😫", "🤓"], color: .pink),
        Theme(name: "Study", contentSet: ["📚", "📖", "✏️", "🖊"], numberOfCards: 4, gradient: Gradient(colors: [.blue, .yellow])),
        Theme(name: "Food", contentSet: ["🍎", "🍕", "🍗", "🍿", "🍫"], gradient: Gradient(colors: [.red, .green])),
    ]}
    
}
