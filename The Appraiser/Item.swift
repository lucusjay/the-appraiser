//
//  Item.swift
//  The Appraiser
//
//  Created by Lucus Landers on 2/24/26.
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
