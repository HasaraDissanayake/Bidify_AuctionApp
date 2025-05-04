//
//  CartViewContentView.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import SwiftUI

// MARK: - Cart View Content
struct CartViewContentView: View {
    @State private var cartItems: [BidItem] = [
        BidItem(id: 1, name: "MacBook Pro", quantity: 1, highestBid: 0, imageName: "laptopcomputer",
                description: "Powerful Apple M2 chip laptop", condition: "Brand New",
                category: "Electronics",
                addedDate: Date().addingTimeInterval(-7200), lastBidTime: Date()),
        
        BidItem(id: 2, name: "Samsung Galaxy S23", quantity: 1, highestBid: 0, imageName: "iphone",
                description: "Latest flagship smartphone from Samsung", condition: "Refurbished",
                category: "Electronics",
                addedDate: Date().addingTimeInterval(-86400), lastBidTime: Date()),

        BidItem(id: 3, name: "Sony Headphones", quantity: 1, highestBid: 0, imageName: "headphones",
                description: "Noise Cancelling Over-ear Headphones", condition: "Brand New",
                category: "Electronics",
                addedDate: Date().addingTimeInterval(-3600), lastBidTime: Date())
    ]

    var body: some View {
        NavigationView {
            VStack {
                if cartItems.isEmpty {
                    // Empty Cart Message
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
                    // Cart List
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(cartItems, id: \.id) { item in
                                CartItemView(item: item, removeAction: {
                                    removeFromCart(item)
                                }, placeBidAction: {
                                    placeBidForItem(item)
                                })
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
                Divider()

                              // Footer (Only once)
                              HStack {
                                  Button(action: {}) {
                                      VStack {
                                          Image(systemName: "house.fill")
                                          Text("Home")
                                              .font(.footnote)
                                      }
                                  }
                                  Spacer()
                                  Button(action: {}) {
                                      VStack {
                                          Image(systemName: "chart.bar.fill")
                                          Text("Dashboard")
                                              .font(.footnote)
                                      }
                                  }
                                  Spacer()
                                  Button(action: {}) {
                                      VStack {
                                          Image(systemName: "heart.fill")
                                          Text("Wishlist")
                                              .font(.footnote)
                                      }
                                  }
                                  Spacer()
                                  Button(action: {}) {
                                      VStack {
                                          Image(systemName: "checkmark.circle.fill")
                                          Text("Completed")
                                              .font(.footnote)
                                      }
                                  }
                                  Spacer()
                                  Button(action: {}) {
                                      VStack {
                                          Image(systemName: "gearshape.fill")
                                          Text("Settings")
                                              .font(.footnote)
                                      }
                                  }
                              }
                              .padding()
                              .foregroundColor(.primaryColor)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Your Cart Items")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryColor)
                }
            }
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }

    // MARK: - Remove Item from Cart
    private func removeFromCart(_ item: BidItem) {
        withAnimation {
            cartItems.removeAll { $0.id == item.id }
        }
    }

    // MARK: - Place a Bid
    private func placeBidForItem(_ item: BidItem) {
        print("Navigating to bid placement for \(item.name)")
        // You can navigate to the bidding screen from here
    }
}

// MARK: - Cart Item Row View
struct CartItemView: View {
    let item: BidItem
    let removeAction: () -> Void
    let placeBidAction: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                Text("Condition: \(item.condition)")
                    .font(.caption)
                    .foregroundColor(.blue)
                
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
                            .background(Color.primaryColor)
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

// MARK: - Preview
struct CartViewContentView_Previews: PreviewProvider {
    static var previews: some View {
        CartViewContentView()
    }
}
