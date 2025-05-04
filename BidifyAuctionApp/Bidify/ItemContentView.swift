//
//  ItemContentView.swift
//  Bidify
//
//  Created by Hasara Dissanayake on 2025-04-04.
//

import SwiftUI

// MARK: - Item Content View
struct ItemContentView: View {
    let item: BidItem
    @State private var timeRemaining: TimeInterval = 259200 // 3 days countdown
    @State private var timerActive: Bool = true
    @State private var userBid: Double?

    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // MARK: - Item Header (Image, Description & Add to Cart)
            HStack(spacing: 12) {
                Image(systemName: item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)

                VStack(alignment: .leading, spacing: 6) {
                    Text(item.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text(item.description)
                        .font(.body)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }

                Spacer()

                // Add to Cart Button (Top Right)
                Button(action: {
                    print("Added to Cart")
                }) {
                    Image(systemName: "cart.badge.plus")
                        .font(.system(size: 22))
                        .foregroundColor(.blue)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
            }

            // MARK: - Countdown Timer
            Text("Time Remaining: \(timeFormatted(timeRemaining))")
                .font(.headline)
                .foregroundColor(.red)
                .onAppear {
                    startCountdown()
                }

            // MARK: - Item Details Section
            VStack(alignment: .leading, spacing: 6) {
                categorySection(title: "Shipping Details", content: [
                    detailRow(title: "Seller", value: "John Doe Auctions"),
                    detailRow(title: "Warranty", value: "6 Months Manufacturer Warranty"),
                    detailRow(title: "Shipping", value: "Available in USA & Canada"),
                    detailRow(title: "Location", value: "New York, USA")
                ])

                categorySection(title: "Price & Bids", content: [
                    detailRow(title: "Highest Bid", value: "$\(String(format: "%.2f", item.highestBid))"),
                    detailRow(title: "Your Bid", value: userBid != nil ? "$\(String(format: "%.2f", userBid!))" : "Not Placed")
                ])

                categorySection(title: "Reviews", content: [
                    detailRow(title: "User Ratings", value: "Rated: 4.2/5 (250 Reviews)"),
                    detailRow(title: "Last Bid Time", value: dateFormatter.string(from: item.lastBidTime))
                ])

                categorySection(title: "Product Details", content: [
                    detailRow(title: "Condition", value: item.condition),
                    detailRow(title: "Added", value: dateFormatter.string(from: item.addedDate))
                ])
            }

            // MARK: - Buttons
            HStack(spacing: 10) {
                Button(action: {
                    timerActive = false
                }) {
                    Text("Cancel")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {}) {
                    Text("Bid")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.6)) // Disabled
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(true)
            }

            Spacer()
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button(action: {
                        // Go back
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
        }
    }

    // MARK: - Timer Handling
    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 && timerActive {
                timeRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }

    // MARK: - Time Formatting
    private func timeFormatted(_ time: TimeInterval) -> String {
        let days = Int(time) / 86400
        let hours = (Int(time) % 86400) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return "\(days)d \(hours)h \(minutes)m \(seconds)s"
    }

    // MARK: - Category Section
    private func categorySection(title: String, content: [some View]) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
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

    // MARK: - Detail Row
    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title + ":")
                .fontWeight(.bold)
            Spacer()
            Text(value)
        }
        .font(.body)
        .foregroundColor(.black)
    }
}

// MARK: - Preview
struct ItemContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemContentView(item: BidItem(
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
            ))
        }
    }
}
