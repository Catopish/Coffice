////
////  Overlay.swift
////  Coffice
////
////  Created by Al Amin Dwiesta on 24/03/25.
////

import SwiftUI

struct coffeeshopInformation: View{
    @Binding var showDetail: Bool
    @Binding var selectedCoffeeshop: CoffeeShopStruct?
    
    var body: some View {
        ZStack {
            if showDetail, let shop = selectedCoffeeshop {
                //shadow
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
                                .font(.title2)
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
                            Text("1 Km")
                        }
                        VStack{
                            Image(systemName: "figure.walk")
                            Text("670 steps")
                        }
                        VStack{
                            Image(systemName: "flame.fill")
                            Text("60 cal")
                        }
                        Spacer()
                    }
                    Color.green
                    //                            Text("Description:")
                    //                                .font(.headline)
                    //                            Text(shop.description)
                    //                                .padding(.bottom, 8)
                    //
                    //                            Text("Location:")
                    //                                .font(.headline)
                    //                            Text(shop.location)
                    //                                .padding(.bottom, 8)
                    //
                    //                            Text("Rating:")
                    //                                .font(.headline)
                    //                            HStack {
                    //                                ForEach(1...5, id: \.self) { star in
                    //                                    Image(systemName: star <= Int(shop.rating) ? "star.fill" : "star")
                    //                                        .foregroundColor(.yellow)
                    //                                }
                    //                                Text(String(format: "%.1f", shop.rating))
                    //                                    .padding(.leading, 4)
                    //                            }
                    
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
