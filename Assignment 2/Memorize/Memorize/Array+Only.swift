//
//  Array+Only.swift
//  Memorize
//
//  Created by Thiago Martins on 29/04/21.
//

import Foundation

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
    
}
