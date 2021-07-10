//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Thiago Martins on 10/07/21.
//

import SwiftUI

struct OptionalImage: View {
    
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
    
}
