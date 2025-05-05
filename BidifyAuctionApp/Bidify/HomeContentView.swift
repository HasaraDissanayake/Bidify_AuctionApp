//
//  HomeContentView.swift
//  Bidify_AuctionApp
//
//  Created by Hasara Dissanayake on 5/4/25.
//

import SwiftUI

// MARK: - Color Extensions
extension Color {
    static let primaryColor = Color(hex: "#5F99AE")
    static let accentColor = Color(hex: "#336D82")
    static let backgroundColor = Color(hex: "#F5ECE0")
}

// MARK: - Hex Color Support
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Dashboard View
struct HomeContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)

            Text("Dashboard")
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Dashboard")
                }
                .tag(1)

            Text("WishList")
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("WishList")
                }
                .tag(2)

            Text("Completed Bids")
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Completed")
                }
                .tag(3)

            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(4)
        }
        .accentColor(.primaryColor)
    }
}

// MARK: - Home View
struct HomeView: View {
    @State private var bidItems: [BidItem] = [
        BidItem(
            id: 1,
            name: "iPhone 14",
            quantity: 1,
            highestBid: 1200,
            imageName: "iphone",
            description: "Latest iPhone model with advanced features.",
            condition: "Brand New",
            category: "Electronics",
            addedDate: Date().addingTimeInterval(-86400),
            lastBidTime: Date().addingTimeInterval(-3600)
        ),
        BidItem(
            id: 2,
            name: "MacBook Pro",
            quantity: 2,
            highestBid: 2200,
            imageName: "laptopcomputer",
            description: "Refurbished 16-inch MacBook Pro with M2 chip.",
            condition: "Refurbished",
            category: "Electronics",
            addedDate: Date().addingTimeInterval(-172800),
            lastBidTime: Date().addingTimeInterval(-7200)
        )
    ]

    @State private var selectedCategory: String = "All"
    @State private var showFilterSheet = false
    @State private var navigateToCreateBid = false
    @State private var navigateToCart = false

    var categories: [String] = ["All", "Art", "Collectables", "Fashion", "Antiques", "Electronics", "Jewelry", "Sports Memos", "Furniture", "Raw Items", "Others"]

    var filteredItems: [BidItem] {
        if selectedCategory == "All" {
            return bidItems
        } else {
            return bidItems.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // AppBar
            HStack {
                Text("Bidify")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                Spacer()

                NavigationLink(destination: CartViewContentView(), isActive: $navigateToCart) {
                    Button(action: {
                        navigateToCart = true
                    }) {
                        Image(systemName: "cart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.primaryColor)
                    }
                }

                NavigationLink(destination: CreateBidView(), isActive: $navigateToCreateBid) {
                    Button(action: {
                        navigateToCreateBid = true
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 10)
                            .foregroundColor(.primaryColor)
                    }
                }

                Button(action: {
                    showFilterSheet = true
                }) {
                    Image(systemName: "line.horizontal.3.decrease")
                        .resizable()
                        .frame(width: 24, height: 17)
                        .padding(.leading, 10)
                        .foregroundColor(.primaryColor)
                }
                .sheet(isPresented: $showFilterSheet) {
                    FilterSheetView(selectedCategory: $selectedCategory, categories: categories)
                }
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)

            // Item List
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(filteredItems) { item in
                        BidItemCard(item: item)
                    }
                }
                .padding()
            }

            Spacer()
        }
        .background(Color.backgroundColor.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

// MARK: - Filter Sheet View
struct FilterSheetView: View {
    @Binding var selectedCategory: String
    let categories: [String]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.self) { category in
                    HStack {
                        Text(category)
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity)
                            .background(Color.primaryColor.opacity(0.5))
                            .cornerRadius(10)
                        Spacer()
                        if category == selectedCategory {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                                .background(Color.primaryColor)
                        }
                    }
                    .contentShape(Rectangle())
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
            .navigationTitle("Filter by Category")
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        dismiss()
                    }) {
                        Text("Done")
                            .foregroundColor(.teal)
                    }
                }
            }
        }
    }
}

// MARK: - Bid Item Card
struct BidItemCard: View {
    let item: BidItem
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 8)
                    .foregroundColor(.primaryColor)
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                    Text("Qty: \(item.quantity)")
                        .font(.subheadline)
                    Text("Highest Bid: $\(item.highestBid, specifier: "%.2f")")
                        .font(.subheadline)
                }
                Spacer()
            }

            Text(item.description)
                .font(.body)
                .foregroundColor(.secondary)

            Text("Condition: \(item.condition)")
                .font(.subheadline)
                .foregroundColor(.accentColor)

            HStack {
                Text("Added: \(dateFormatter.string(from: item.addedDate))")
                Spacer()
                Text("Last Bid: \(dateFormatter.string(from: item.lastBidTime))")
            }
            .font(.footnote)
            .foregroundColor(.gray)

            Button(action: {
                // View item details
            }) {
                Text("View Item")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.15), radius: 5, x: 0, y: 3)
    }
}

// MARK: - Model
struct BidItem: Identifiable {
    let id: Int
    let name: String
    let quantity: Int
    let highestBid: Double
    let imageName: String
    let description: String
    let condition: String
    let category: String
    let addedDate: Date
    let lastBidTime: Date
}

// MARK: - Preview
struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
