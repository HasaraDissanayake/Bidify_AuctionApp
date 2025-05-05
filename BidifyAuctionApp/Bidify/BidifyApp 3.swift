//
//  BidifyApp.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import Foundation
import SwiftUI

class BidManager: ObservableObject {
    @Published var bidItems: [Bid_Item] = [] {
        didSet {
            saveItemsToUserDefaults()
        }
    }

    func addItem(_ item: Bid_Item) {
        bidItems.append(item)
    }

    func saveItemsToUserDefaults() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(bidItems.map { $0.toCodable() }) {
            UserDefaults.standard.set(data, forKey: "bidItems")
        }
    }

    func loadItemsFromUserDefaults() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "bidItems"),
           let codableItems = try? decoder.decode([CodableBidItem].self, from: data) {
            bidItems = codableItems.map { $0.toBidItem() }
        }
    }
}

