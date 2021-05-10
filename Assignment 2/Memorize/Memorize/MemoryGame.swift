//
//  MemoryGame.swift
//  Memorize
//
//  Created by Thiago Martins on 11/04/21.
//
//  Model

import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    var theme: Theme
    var cards: Array<Card>
    private(set) var score: Double = 0
    
    private var alreadySeenCardIds: Array<Int> = []
    private var lastCardChosenTime: Date?
    
    private let matchBaseScore: Double = 2
    private let mismatchBaseScore: Double = -1
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    private var secondsSinceLastCardWasChosen: TimeInterval {
        return Date().timeIntervalSince(lastCardChosenTime!)
    }
    
    init(theme: Theme, numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.theme = theme
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    match()
                } else {
                    if alreadySeenCardIds.contains(cards[chosenIndex].id) {
                        mismatch()
                        if alreadySeenCardIds.filter({ $0 == cards[chosenIndex].id }).count > 1 {
                            mismatch()
                        }
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                lastCardChosenTime = Date()
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            alreadySeenCardIds.append(cards[chosenIndex].id)
        }
    }
    
    private mutating func match() {
        score += scoreByTime(matchBaseScore)
    }
    
    private mutating func mismatch() {
        score += scoreByTime(mismatchBaseScore)
    }
    
    private func scoreByTime(_ baseScore: Double) -> Double {
        return max(10 - secondsSinceLastCardWasChosen, 1) * baseScore
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
}

extension MemoryGame {
    
    struct Theme {
        let name: String
        let contentSet: Array<CardContent>
        let numberOfCards: Int
        let color: Color?
        let gradient: Gradient?
        
        init(name: String, contentSet: Array<CardContent>, numberOfCards: Int? = nil, color: Color) {
            self.name = name
            self.contentSet = contentSet.shuffled()
            self.numberOfCards = numberOfCards ?? Int.random(in: 0..<contentSet.count)
            self.color = color
            self.gradient = nil
        }
        
        init(name: String, contentSet: Array<CardContent>, numberOfCards: Int? = nil, gradient: Gradient) {
            self.name = name
            self.contentSet = contentSet.shuffled()
            self.numberOfCards = numberOfCards ?? Int.random(in: 0..<contentSet.count)
            self.gradient = gradient
            self.color = nil
        }
        
    }
    
}
