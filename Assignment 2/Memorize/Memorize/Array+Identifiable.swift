//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Thiago Martins on 28/04/21.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching element: Element) -> Int? {
        return self.firstIndex { $0.id == element.id }
    }
    
}
