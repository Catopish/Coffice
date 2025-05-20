import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct CategoryHome: View {
    var coffeeShop: [CoffeeShopStruct]
    @Binding var showMapView: Bool
    
    private var betterprice: [CoffeeShopStruct] {
        coffeeShop.filter { shop in
            shop.menu.contains { item in
                item.price >= 5 && item.price <= 23
            }
        }
    }
    
    private var extraSteps: [CoffeeShopStruct] {
        coffeeShop
            .filter { $0.steps >= 300 && $0.steps <= 6000000000 }
            .sorted { $0.steps > $1.steps }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    
                   
                    Text("Better price")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(betterprice) { shop in
                                CoffeeShopCard(shop: shop, showMapView: $showMapView, showPriceTag: true)
                            }
                        }
                    }
                    .padding(.bottom, 24)
                    
                    if !extraSteps.isEmpty {
                        Text("Extra steps")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack() {
                                ForEach(extraSteps) { shop in
                                    CoffeeShopCard(shop: shop, showMapView: $showMapView, showPriceTag: false)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CoffeeShopCard: View {
    let shop: CoffeeShopStruct
    @Binding var showMapView: Bool
    let showPriceTag: Bool
    
    var body: some View {
        NavigationLink(destination: DetailedInformation(shop: shop, showMapView: $showMapView)) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.primary.opacity(0.2), radius: 2, x: 1, y: 1)
                
                VStack(alignment: .leading) {
                    Image("\(shop.name)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 110)
                        .clipShape(RoundedCorner(radius: 12, corners: [.topLeft, .topRight]))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(shop.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        
                        if showPriceTag {
                            HStack(spacing: 4) {
                                Image(systemName: "tag.fill")
                                    .font(.caption2)
                                    .foregroundColor(.primary)
                                Text("Start from Rp20K")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                        } else {
                            HStack(spacing: 4) {
                                Image(systemName: "figure.walk")
                                    .font(.caption2)
                                    .foregroundColor(.primary)
                                Text("\(shop.steps) steps")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        Text(shop.location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(8)
                    
                }
            }
            .frame(width: 160, height: 200)
            .padding(4)
            
        }
        .buttonStyle(.plain)
        
    }
}



#Preview {
    Homepage()
}

