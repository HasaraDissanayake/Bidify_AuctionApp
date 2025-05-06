//
//  BidItemModel.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import SwiftUI

struct Bid_Item: Identifiable {
    let id: UUID
    let itemName: String
    let description: String
    let category: String
    let condition: String
    let image: UIImage?
    let sellerName: String
    let email: String
    let contact: String
    let location: String
    let createdDate: Date

    func toCodable() -> CodableBidItem {
        CodableBidItem(
            id: id,
            itemName: itemName,
            description: description,
            category: category,
            condition: condition,
            imageData: image?.jpegData(compressionQuality: 0.8),
            sellerName: sellerName,
            email: email,
            contact: contact,
            location: location,
            createdDate: createdDate
        )
    }
}

struct CodableBidItem: Codable {
    let id: UUID
    let itemName: String
    let description: String
    let category: String
    let condition: String
    let imageData: Data?
    let sellerName: String
    let email: String
    let contact: String
    let location: String
    let createdDate: Date

    func toBidItem() -> Bid_Item {
        Bid_Item(
            id: id,
            itemName: itemName,
            description: description,
            category: category,
            condition: condition,
            image: imageData.flatMap { UIImage(data: $0) },
            sellerName: sellerName,
            email: email,
            contact: contact,
            location: location,
            createdDate: createdDate
        )
    }
}
