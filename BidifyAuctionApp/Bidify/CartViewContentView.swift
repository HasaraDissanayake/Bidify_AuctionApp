//
//  CartViewContentView.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import SwiftUI

struct CartViewContentView: View {
    @EnvironmentObject var bidManager: BidManager

    var body: some View {
        NavigationView {
            VStack {
                if bidManager.cartItems.isEmpty {
                    VStack {
                        Image(systemName: "cart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                        Text("Your cart is empty!")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(bidManager.cartItems, id: \.id) { item in
                                CartItemView(
                                    item: item,
                                    removeAction: { bidManager.removeFromCart(item) },
                                    placeBidAction: { placeBidForItem(item) }
                                )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Your Cart Items")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.teal)
                }
            }
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }

    private func placeBidForItem(_ item: Bid_Item) {
        print("Navigate to bidding for \(item.itemName)")
        // TODO: Implement navigation
    }
}

struct CartItemView: View {
    let item: Bid_Item
    let removeAction: () -> Void
    let placeBidAction: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            if let uiImage = item.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                    .shadow(radius: 2)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(item.itemName)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)

                Text("Condition: \(item.condition)")
                    .font(.caption)
                    .foregroundColor(.teal)

                Text("Category: \(item.category)")
                    .font(.caption)
                    .foregroundColor(.teal)

                HStack {
                    Button(action: removeAction) {
                        Text("Remove")
                            .font(.caption)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: placeBidAction) {
                        Text("Place a Bid")
                            .font(.caption)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(Color.teal)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct CartViewContentView_Previews: PreviewProvider {
    static var previews: some View {
        CartViewContentView()
            .environmentObject(BidManager())
    }
}
