////
////  Overlay.swift
////  Coffice
////
////  Created by Al Amin Dwiesta on 24/03/25.
////

import SwiftUI
import MapKit

struct coffeeshopInformation: View{
    
    @State var showMapView: Bool = false
    @Binding var showDetail: Bool
    @Binding var selectedCoffeeshop: CoffeeShopStruct?
        
    var body: some View {
        ZStack {
            if showDetail, let shop = selectedCoffeeshop {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .ignoresSafeArea()
                    .onTapGesture {
                        showDetail = false
                    }
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(shop.name)
                            .font(.title)
                            .bold()
                        Spacer()
                        Button(action: {
                            showDetail = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .font(.title)
                        }
                    }
                    
                    Divider()
                    HStack{
                        Spacer()
                        Image("Starbucks")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300,height: 200)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        VStack{
                            Image(systemName: "location.fill")
                            Text(String(shop.distance))
                        }
                        VStack{
                            Image(systemName: "figure.walk")
                            Text(String(shop.steps))
                        }
                        VStack{
                            Image(systemName: "flame.fill")
                            Text(String(shop.calories))
                        }
                        Spacer()
                    }
                    
                    VStack{
                        Button("tes"){
                            showMapView=true
                        }
                    }.fullScreenCover(isPresented: $showMapView) {
                        MapView(coordinate: CLLocationCoordinate2D(latitude: -6.3019094, longitude: 106.6517333))
                    }
                    Color.green
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
                .transition(.scale)
                .frame(width: 400, height: 500)
            }
        }
    }
}
