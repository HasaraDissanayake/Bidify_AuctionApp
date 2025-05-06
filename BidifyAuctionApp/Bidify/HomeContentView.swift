//
//  HomeContentView.swift
//  Bidify_AuctionApp
//
//  Created by Hasara Dissanayake on 5/4/25.
//

import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject var bidManager: BidManager
    @State private var selectedCategory: String = "All"
    @State private var isCategoryPickerPresented: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true // ✅ Persisted login state

    var categories: [String] = ["All", "Art", "Collectables", "Fashion", "Antiques", "Electronics", "Jewelry", "Sports Memo", "Furniture", "Others"]

    var filteredItems: [Bid_Item] {
        selectedCategory == "All" ? bidManager.bidItems : bidManager.bidItems.filter { $0.category == selectedCategory }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                // Top bar
                VStack(alignment: .leading, spacing: 4) {
                    // Centered "Home" title
                    HStack {
                        Spacer()
                        Text("Home")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.teal)
                        Spacer()
                    }

                    // Sign Out button below title, left-aligned
                    Button(action: {
                        signOut()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.left")
                            Text("Sign Out")
                        }
                        .font(.headline)
                        .foregroundColor(.red)
                    }
                    .padding(.leading, 16)

                    // Right-side icons
                    HStack {
                        Spacer()

                        // Filter button
                        Button(action: {
                            isCategoryPickerPresented.toggle()
                        }) {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 8)

                        // "+" button to create bid
                        NavigationLink(destination: CreateBidView()) {
                            Text("+")
                                .font(.title2)
                                .foregroundColor(.black)
                                .frame(width: 36, height: 36)
                                .background(Circle().fill(Color.white))
                        }
                        .padding(.trailing, 8)

                        // Cart icon
                        NavigationLink(destination: CartViewContentView()) {
                            Image(systemName: "cart.fill")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 5)

                // Category Picker Sheet
                if isCategoryPickerPresented {
                    VStack {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                                isCategoryPickerPresented = false
                            }) {
                                Text(category)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.teal.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                }

                // Items List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredItems) { item in
                            BidRowView(item: item)
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .onAppear {
                bidManager.loadItemsFromUserDefaults()
            }
        }
    }

    private func signOut() {
        isLoggedIn = false // ✅ Triggers transition to LoginInterface
    }
}

// MARK: - BidRowView

struct BidRowView: View {
    let item: Bid_Item

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Image
            if let image = item.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 160)
                    .cornerRadius(10)
                    .clipped()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
                    .foregroundColor(.gray)
                    .cornerRadius(10)
                    .clipped()
            }

            // Info
            VStack(alignment: .leading, spacing: 8) {
                Text(item.itemName)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Category: \(item.category) | Condition: \(item.condition)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            // View Item Navigation Button
            NavigationLink(destination: ItemContentView(item: item)) {
                Text("View Item")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Color.teal, Color.teal.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .padding(.vertical)
        .background(Color.teal.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// MARK: - Preview

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        let bidManager = BidManager()
        bidManager.bidItems = [
            Bid_Item(
                id: UUID(),
                itemName: "Vintage Clock",
                description: "A rare vintage clock",
                category: "Antiques",
                condition: "Used",
                image: nil,
                sellerName: "John Doe",
                email: "john@example.com",
                contact: "123-456-7890",
                location: "New York",
                createdDate: Date()
            ),
            Bid_Item(
                id: UUID(),
                itemName: "Diamond Necklace",
                description: "A beautiful necklace",
                category: "Jewelry",
                condition: "New",
                image: nil,
                sellerName: "Jane Doe",
                email: "jane@example.com",
                contact: "987-654-3210",
                location: "Los Angeles",
                createdDate: Date()
            )
        ]

        return HomeContentView()
            .environmentObject(bidManager)
    }
}
