import SwiftUI

struct WrapLayout<Item: Hashable, Content: View>: View {
    var items: [Item]
    var content: (Item) -> Content
    
    var body: some View {
        FlexibleView(
            data: items,
            spacing: 10,
            alignment: .leading,
            content: content
        )
    }
}

struct FlexibleView<Data: Hashable, Content: View>: View {
    let data: [Data]
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data) -> Content
    
    @State private var sizes: [Data: CGSize] = [:]
    
    var body: some View {
        var rows: [[Data]] = []
        var currentRow: [Data] = []
        var currentWidth: CGFloat = 0
        let screenWidth = UIScreen.main.bounds.width - 20
        
        for item in data {
            let itemSize = sizes[item, default: CGSize(width: screenWidth, height: 10)]
            if currentWidth + itemSize.width + spacing > screenWidth {
                rows.append(currentRow)
                currentRow = [item]
                currentWidth = itemSize.width + spacing
            } else {
                currentRow.append(item)
                currentWidth += itemSize.width + spacing
            }
        }
        if !currentRow.isEmpty {
            rows.append(currentRow)
        }
        
        return VStack(alignment: alignment, spacing: spacing) {
            ForEach(0..<rows.count, id: \.self) { rowIndex in
                HStack(spacing: spacing) {
                    ForEach(rows[rowIndex], id: \.self) { item in
                        content(item)
                            .fixedSize()
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            sizes[item] = geo.size
                                        }
                                }
                            )
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    FilterSheetView()
//}


struct FilterSheetView: View {
    let coffeeTypes = ["Americano", "Cappuccino", "Espresso", "Frappuccino", "Latte", "Mocha", "Non Coffee"]
    let distances = ["Farthest", "Nearest"]
    let prices = ["Cheapest", "Most Expensive"]
    
    var initialCoffeeTypes: Set<String>
    var initialDistance: String?
    var initialPrice: String?
    
    @State private var selectedCoffeeTypes: Set<String> = []
    @State private var selectedDistance: String?
    @State private var selectedPrice: String?
    
    var onApplyFilter: ((_ coffeeTypes: Set<String>, _ distance: String?, _ price: String?) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 48) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Filter")
                    .font(.title2).bold()
                    .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Coffee")
                        .font(.headline).bold()
                    
                    WrapLayout(items: coffeeTypes) { type in
                        Text(type)
                            .font(.subheadline)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .foregroundColor(.primary)
                            .background(
                                Capsule()
                                    .fill(selectedCoffeeTypes.contains(type) ? Color.brown5 : Color(.systemBackground))
                            )
                            .overlay(
                                Capsule()
                                    .stroke(Color.brown, lineWidth: 1)
                            )
                            .onTapGesture {
                                if selectedCoffeeTypes.contains(type) {
                                    selectedCoffeeTypes.remove(type)
                                } else {
                                    selectedCoffeeTypes.insert(type)
                                }
                            }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Sort by")
                    .font(.title2).bold()
                
                Text("Distance")
                    .font(.headline).bold()
                
                WrapLayout(items: distances) { distance in
                    Text(distance)
                        .font(.subheadline)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .foregroundColor(.primary)
                        .background(
                            Capsule()
                                .fill(selectedDistance == distance ? Color.brown5 : Color(.systemBackground))
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.brown, lineWidth: 1)
                        )
                        .onTapGesture {
                            selectedDistance = distance
                        }
                }
                
                Text("Price")
                    .font(.headline).bold()
                
                WrapLayout(items: prices) { price in
                    Text(price)
                        .font(.subheadline)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .foregroundColor(.primary)
                        .background(
                            Capsule()
                                .fill(selectedPrice == price ? Color.brown5 : Color(.systemBackground))
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.brown, lineWidth: 1)
                        )
                        .onTapGesture {
                            selectedPrice = price
                        }
                }
            }
            
            HStack(spacing: 8) {
                Button {
                    selectedCoffeeTypes.removeAll()
                    selectedDistance = nil
                    selectedPrice = nil
                } label: {
                    Text("Reset")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.brown1, lineWidth: 1)
                        )
                        .foregroundColor(.brown1)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                Button {
                    onApplyFilter?(selectedCoffeeTypes, selectedDistance, selectedPrice)
                } label: {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(uiColor: .brown1))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
        }
        .onAppear {
            selectedCoffeeTypes = initialCoffeeTypes
            selectedDistance = initialDistance
            selectedPrice = initialPrice
        }
        .padding(.horizontal)
        .presentationDetents([.height(520)])
    }
}
