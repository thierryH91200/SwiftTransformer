//
//  Item.swift
//  SwiftTransformer
//
//  Created by Thierry hentic on 13/11/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
