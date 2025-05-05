//
//  ItemContentView.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import SwiftUI

struct ItemContentView: View {
    let item: Bid_Item
    @State private var timeRemaining: TimeInterval = 259200 // 3 days
    @State private var timerActive: Bool = true
    @State private var userBid: Double?
    @EnvironmentObject var bidManager: BidManager
    @State private var showAddToCartAlert = false

    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image and Title Section
                HStack(spacing: 12) {
                    if let uiImage = item.image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 90)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 90)
                            .foregroundColor(.gray)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.itemName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.teal)

                        Text(item.description)
                            .font(.body)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }

                    Spacer()

                    Button(action: {
                        bidManager.addToCart(item)
                        showAddToCartAlert = true
                    }) {
                        Image(systemName: "cart.badge.plus")
                            .font(.system(size: 22))
                            .foregroundColor(.teal)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                }

                // Countdown Timer
                Text("Time Remaining: \(timeFormatted(timeRemaining))")
                    .font(.headline)
                    .foregroundColor(.red)
                    .onAppear {
                        startCountdown()
                    }

                // Shipping Info
                categorySection(title: "Shipping Details", content: [
                    detailRow(title: "Seller", value: item.sellerName),
                    detailRow(title: "Email", value: item.email),
                    detailRow(title: "Contact", value: item.contact),
                    detailRow(title: "Location", value: item.location)
                ])

                // Bidding Info
                categorySection(title: "Bidding Info", content: [
                    detailRow(title: "Your Bid", value: userBid != nil ? "$\(String(format: "%.2f", userBid!))" : "Not Placed"),
                    detailRow(title: "Listed On", value: dateFormatter.string(from: item.createdDate))
                ])

                // Product Info
                categorySection(title: "Product Info", content: [
                    detailRow(title: "Condition", value: item.condition),
                    detailRow(title: "Category", value: item.category),
                    detailRow(title: "Description", value: item.description)
                ])

                // Action Buttons
                HStack(spacing: 10) {
                    Button(action: {
                        timerActive = false
                        print("Cancelled")
                    }) {
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        print("Bid action tapped")
                    }) {
                        Text("Bid")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.teal)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.ignoresSafeArea())
        .alert(isPresented: $showAddToCartAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Item successfully added to the cart."),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // MARK: - Timer
    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 && timerActive {
                timeRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }

    // MARK: - Format Time
    private func timeFormatted(_ time: TimeInterval) -> String {
        let days = Int(time) / 86400
        let hours = (Int(time) % 86400) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return "\(days)d \(hours)h \(minutes)m \(seconds)s"
    }

    // MARK: - Detail Section
    private func categorySection(title: String, content: [some View]) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .padding(.top, 4)

            VStack(spacing: 4) {
                ForEach(0..<content.count, id: \.self) { index in
                    content[index]
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
        }
    }

    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title + ":")
                .fontWeight(.bold)
            Spacer()
            Text(value)
        }
        .font(.body)
        .foregroundColor(.gray)
    }
}

// MARK: - Preview
struct ItemContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemContentView(item: Bid_Item(
                id: UUID(),
                itemName: "iPhone 14",
                description: "Latest iPhone model with advanced features.",
                category: "Electronics",
                condition: "Brand New",
                image: nil,
                sellerName: "John Doe",
                email: "john@example.com",
                contact: "1234567890",
                location: "New York, USA",
                createdDate: Date()
            ))
            .environmentObject(BidManager())
        }
    }
}
