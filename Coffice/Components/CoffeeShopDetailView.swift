////
////  Overlay.swift
////  Coffice
////
////  Created by Al Amin Dwiesta on 24/03/25.
////

import SwiftUI
import MapKit
struct CoffeeShopDetailView: View {
    var selectedCoffeeShop: CoffeeShopStruct?
    @State var showMapView: Bool = false
   
    
    var body: some View {
        if let shop = selectedCoffeeShop {
            ZStack(alignment: .bottom) {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.86, green: 0.64, blue: 0.50),
                        .white
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 0) {
                        ZStack{
                            Image("\(shop.name)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            //                        .frame(width: 77, height: 112)
                                .ignoresSafeArea()
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: 294)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.black, .clear]),
                                        startPoint: .bottom,
                                        endPoint: .top
                                    )
                                )
                                .opacity(0.6)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.25), radius: 4, y: 1)
                            VStack(alignment: .leading, spacing: 9) {
                                Text(shop.name)
                                    .font(Font.custom("SF Pro", size: 24).weight(.bold))
                                    .tracking(0.50)
                                    .lineSpacing(22)
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 14) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "map.fill")
                                            .foregroundColor(Color(red: 0.66, green: 0.36, blue: 0.18))
                                        Text("\(Int(shop.distance)) m")
                                    }
                                    HStack(spacing: 4) {
                                        Image(systemName: "figure.walk")
                                            .foregroundColor(Color(red: 0.66, green: 0.36, blue: 0.18))
                                        Text("\(shop.steps) steps")
                                    }
                                    HStack(spacing: 4) {
                                        Image(systemName: "flame.fill")
                                            .foregroundColor(Color(red: 0.66, green: 0.36, blue: 0.18))
                                        Text("\(shop.calories) kcal")
                                    }
                                    Spacer()
                                }
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(red: 0.28, green: 0.23, blue: 0.16))
                            }
                            .padding(.horizontal, 13)
                            .padding(.vertical, 10)
                        }
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(0..<8) { _ in
                                MediumCoffeeCard()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 50)
                    }
                }
                .ignoresSafeArea(edges: .top)
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 78)
                        .shadow(color: Color.black.opacity(0.25), radius: 4)
                        .padding(.bottom,-40)
                    
                    Button(action: {
                       showMapView = true
                    }) {
                        Text("Begin your walk")
                            .font(Font.custom("SF Pro Rounded", size: 24))
                            .foregroundColor(.white)
                            .frame(width: 372, height: 41)
                            .background(Color(red: 0.66, green: 0.36, blue: 0.18))
                            .cornerRadius(35)
                            .padding(.bottom,-20)
                    }
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
//            .fullScreenCover(isPresented: $showMapView){
//                MapView(streakManager: <#T##StreakManager#>, coffeShops: <#T##Binding<CoffeeShopStruct?>#>, liveViewModel: <#T##LiveActivityViewModel#>, hasArrivedAtDestination: <#T##Binding<Bool>#>)
//            }
        } else {
            Text("No coffee shop selected")
        }
    }
}


//#Preview {
//    CoffeeShopDetailView()
//}
