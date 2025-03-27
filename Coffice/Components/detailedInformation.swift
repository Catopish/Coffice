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
                // Shadow overlay
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .ignoresSafeArea()
                    .onTapGesture {
                        showDetail = false
                    }
                
                VStack(spacing: 12) {
                    ZStack {
                        VStack{
                            Text(shop.name)
                                .font(.title)
                                .bold()
                                .frame(maxWidth: .infinity)
                            Text(shop.location)
                                .font(.subheadline)
                                .bold()
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                        }
                        
                        Button(action: {
                            showDetail = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .font(.title)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .offset(x: 150, y: -15)
                        
                        
                    }
                    
                    Divider()
                    VStack {
                        Image("Starbucks")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 200) // Mengisi lebar penuh
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    HStack(spacing: 30) {
                        Spacer()
                        VStack {
                            Image(systemName: "location.north.line.fill")
                                .resizable()
                                .frame(width: 30, height: 40)
                                .foregroundStyle(Color(uiColor: .primary))
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text("\(shop.distance, specifier: "%.1f")")
                                    .padding(.top, 5)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                Text("m")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                            }
                        }
                        VStack {
                            Image(systemName: "figure.walk")
                                .resizable()
                                .frame(width: 30, height: 40)
                                .foregroundStyle(Color(uiColor: .primary))
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text("\(shop.steps)")
                                    .padding(.top, 5)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                Text("steps")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                            }
                            
                        }
                        VStack {
                            Image(systemName: "flame.fill")
                                .resizable()
                                .frame(width: 30, height: 40)
                                .foregroundStyle(Color(uiColor: .primary))
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text("\(shop.calories)")
                                    .padding(.top, 5)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                Text("kcal")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    Divider()
                    
                    VStack {
                        Button {
                            showMapView = true
                        } label: {
                            Text("Get Started")
                                .padding(.horizontal, 85)
                                .padding(.vertical)
                                .foregroundColor(.white)
                                .background(Color(uiColor: .primary))
                                .cornerRadius(20)
                        }
                        .fullScreenCover(isPresented: $showMapView) {
                            MapView(coordinate: CLLocationCoordinate2D(latitude: -6.3019094, longitude: 106.6517333))
                        }
                    }
                    .padding(.bottom)
                    
                    }
                    .padding(.top, 20)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .padding(.horizontal, 20)
                    .transition(.scale)
                    .frame(width: 400, height: 550)
                }
            }
        }
    }

