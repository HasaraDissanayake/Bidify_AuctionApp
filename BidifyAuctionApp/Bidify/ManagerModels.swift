//
//  ManagerModels.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import Foundation
import SwiftUI

class BidManager: ObservableObject {
    // MARK: - Published Properties
    @Published var bidItems: [Bid_Item] = [] {
        didSet {
            saveItemsToUserDefaults()
        }
    }

    @Published var cartItems: [Bid_Item] = [] {
        didSet {
            saveCartToUserDefaults()
        }
    }

    @Published var wishlistItems: [Bid_Item] = [] {
        didSet {
            saveWishlistToUserDefaults()
        }
    }

    // MARK: - Bid Management
    func addItem(_ item: Bid_Item) {
        bidItems.append(item)
    }

    public func saveItemsToUserDefaults() {
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

    // MARK: - Cart Management
    func addToCart(_ item: Bid_Item) {
        if !cartItems.contains(where: { $0.id == item.id }) {
            cartItems.append(item)
        }
    }

    func removeFromCart(_ item: Bid_Item) {
        cartItems.removeAll { $0.id == item.id }
    }

    private func saveCartToUserDefaults() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(cartItems.map { $0.toCodable() }) {
            UserDefaults.standard.set(data, forKey: "cartItems")
        }
    }

    func loadCartFromUserDefaults() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "cartItems"),
           let codableItems = try? decoder.decode([CodableBidItem].self, from: data) {
            cartItems = codableItems.map { $0.toBidItem() }
        }
    }

    // MARK: - Wishlist Management
    func addToWishlist(_ item: Bid_Item) {
        if !wishlistItems.contains(where: { $0.id == item.id }) {
            wishlistItems.append(item)
        }
    }

    func removeFromWishlist(_ item: Bid_Item) {
        wishlistItems.removeAll { $0.id == item.id }
    }

    private func saveWishlistToUserDefaults() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(wishlistItems.map { $0.toCodable() }) {
            UserDefaults.standard.set(data, forKey: "wishlistItems")
        }
    }

    func loadWishlistFromUserDefaults() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "wishlistItems"),
           let codableItems = try? decoder.decode([CodableBidItem].self, from: data) {
            wishlistItems = codableItems.map { $0.toBidItem() }
        }
    }

    // MARK: - Load All
    func loadAll() {
        loadItemsFromUserDefaults()
        loadCartFromUserDefaults()
        loadWishlistFromUserDefaults()
    }
}
