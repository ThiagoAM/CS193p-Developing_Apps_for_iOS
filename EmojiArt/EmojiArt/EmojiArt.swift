//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Thiago Martins on 03/07/21.
//

import Foundation

struct EmojiArt: Codable {
    
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Codable {
        let text: String
        var x: Int // offset from center
        var y: Int // offset from center
        var size: Int
        let id: Int
        
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
        
    }
    
    var json: Data? {
        try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let emojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!) {
            self = emojiArt
        }
    }
    
    init() {}
    
    private var uniqueEmojiID: Int = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiID += 1
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiID))
    }
    
}
