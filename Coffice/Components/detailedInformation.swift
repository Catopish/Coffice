import SwiftUI
import MapKit

struct DetailedInformation: View {
    var shop: CoffeeShopStruct
    @Binding var showMapView: Bool
    //        @Binding var showDetail: Bool
    //        @Binding var selectedCoffeeshop: CoffeeShopStruct?
    
    var body: some View {
        ScrollView {
            VStack() {
                Image("\(shop.name)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 224)
                    .clipped()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(shop.name)
                                .font(.title)
                                .bold()
                            
                            Text(shop.location)
                                .font(.subheadline)
                            
                            HStack (spacing: 16){
                                HStack(spacing: 4) {
                                    Image(systemName: "location.north.line.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18, height: 18)
                                        .foregroundStyle(Color(uiColor: .brown1))
                                    Text("\(Int(shop.distance)) m")
                                        .font(.subheadline)
                                }
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "flame.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18, height: 18)
                                        .foregroundStyle(Color(uiColor: .brown1))
                                    Text("\(shop.calories) kcal")
                                        .font(.subheadline)
                                }
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "figure.walk")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18, height: 18)
                                        .foregroundStyle(Color(uiColor: .brown1))
                                    Text("\(shop.steps) steps")
                                        .font(.subheadline)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            //                             Action
                            //                        showDetail = false
                            showMapView = true
                        } label: {
                            Text("Go")
                                .frame(width: 90, height: 80)
                                .background(Color(uiColor: .brown1))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About")
                            .font(.title3)
                            .bold()
                        Text(shop.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 24)
                    
                    
                    Text("Menu")
                        .font(.title3)
                        .bold()
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(shop.menu) { item in
                            HStack(spacing: 12) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    )
                                    .overlay(                                            // (opsional) border di sekeliling
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.subheadline)
                                    Text("Rp \(Int(item.price)).000")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        }
    }



#Preview {
    Homepage()
}
//   
