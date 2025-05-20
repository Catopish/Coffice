import SwiftUI

struct PopularBrandRow: View {
    let shops: [CoffeeShopStruct]
    @Binding var showMapView: Bool
    
    var body: some View {
        let popularNames = ["Starbucks", "Fore", "Kenangan Signature", "% Arabica", "Tamper", "Lawson"]
        let popularShops = shops.filter { popularNames.contains($0.name) }
        
        return VStack (alignment: .leading, spacing: 4) {
            VStack (alignment: .leading) {
                Text("Popular brands")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(popularShops) { shop in
                        NavigationLink(destination: DetailedInformation(shop: shop, showMapView: $showMapView)) {
                            Image(shop.logo)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .background(
                                    Circle()
                                        .fill(Color(.systemBackground))
                                        .frame(width: 60, height: 60))
                                .shadow(color: Color.primary.opacity(0.1), radius: 2, x: 1, y: 1)
                                .padding(4)
                                
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(4)
            }
        }
        .padding(.bottom, 16)

    }
}

//
