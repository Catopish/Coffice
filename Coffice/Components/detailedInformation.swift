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
                                .font(.title2)
                                .foregroundColor(Color("brown3"))
                                .bold()
                                .frame(maxWidth: .infinity)
                            Text(shop.location)
                                .font(.body)
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
                        .offset(x: 140, y: -15)
                        
                        
                    }
                    
//                    Divider()
                    VStack {
                        Image("Starbucks")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 180) // Mengisi lebar penuh
//                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.top, 20)
                    }
                    
                    HStack(spacing: 30) {
                        Spacer()
                        VStack {
                            Image(systemName: "location.north.line.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .frame(width: 30, height: 40)
                                .foregroundStyle(Color(uiColor: .brown2))
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text("\(shop.distance, specifier: "%.1f")")
                                    .padding(.top, 5)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                    .foregroundColor(Color("brown3"))
                                Text("M")
                                    .font(.footnote)
                                    .foregroundColor(Color("brown3"))
                                
                            }
                        }
                        VStack {
                            Image(systemName: "flame.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .frame(width: 30, height: 40)
                                .foregroundStyle(Color(uiColor: .brown2))
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text("\(shop.calories)")
                                    .padding(.top, 5)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                    .foregroundColor(Color("brown3"))
                                Text("CAL")
                                    .font(.footnote)
                                    .foregroundColor(Color("brown3"))
                                
                            }
                            
                        }
                        VStack {
                            Image(systemName: "figure.walk")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color(uiColor: .brown2))
                                .foregroundColor(Color("brown3"))
                                .frame(width: 30, height: 40)
                                .foregroundStyle(Color(uiColor: .brown2))

                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text("\(shop.steps)")
                                    .padding(.top, 5)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                    .foregroundColor(Color("brown3"))
                                Text("STEPS")
                                    .font(.footnote)
                                    .foregroundColor(Color("brown3"))
                            }
                            
                        }
                        Spacer()
                    }
                    .padding(.vertical, 20)
                    
//                    Divider()
                    
                    VStack {
                        Button {
                            showMapView = true
                        } label: {
                            Text("Get Started")
                                .frame(maxWidth: .infinity, maxHeight: 20)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(uiColor: .brown2))
                                .cornerRadius(12)
                                .padding(.horizontal)
                                .cornerRadius(20)
                        }
                        .fullScreenCover(isPresented: $showMapView) {
//                            MapView(coordinate: CLLocationCoordinate2D(latitude: -6.3019094, longitude: 106.6517333))
//                            MapWalking()
                            MapView(coffeShops: $selectedCoffeeshop)
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
                    .frame(width: 380, height: 460)
                }
            }
        }
    }

