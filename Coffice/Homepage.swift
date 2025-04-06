//
//  ContentView.swift
//  Coffice
//
//  Created by Hafi on 20/03/25.
//

import SwiftUI
import SwiftData
import HealthKit
import CoreLocation

struct CoffeeShopStruct: Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var description: String
    var distance: Double
    var steps: Int
    var calories: Int
    var latitude: Double
    var longitude: Double
    
    
}

//Contoh buat max range
@Observable
class filterModel: ObservableObject {
    var maxRange: Double
    
    init(maxRange: Double) {
        self.maxRange = maxRange
    }
}

struct Homepage: View {
    @State private var streak: Int = 0
    @AppStorage("userName") var userName: String = ""
    @StateObject private var healthViewModel = HealthDashboardViewModel()
    @State var isLoading: Bool = false
    @StateObject var locationManager = LocationManager()    
    @State private var searchContent: String = ""
    @State private var showDetail: Bool = false
    @State private var selectedCoffeeshop: CoffeeShopStruct? = nil
    @State private var showOnboarding: Bool = false
    
    let coffeeShop : [CoffeeShopStruct] = [
        //        CoffeeShopStruct(name: "Starbucks",location: "Lorem Ipsum", description: "lorem",distance: 127,steps: 123,calories: 123),
        //        CoffeeShopStruct(name: "Fore",location: "Lorem Ipsum", description: "lorem",distance: 45 ,steps: 54,calories: 134),
        //        CoffeeShopStruct(name: "Tamper",location: "Lorem Ipsum", description: "lorem",distance: 431,steps: 887,calories: 1223),
        //        CoffeeShopStruct(name: "Kopi Kenangan",location: "Lorem Ipsum", description: "lorem",distance: 134,steps: 412,calories: 531),
        //        CoffeeShopStruct(name: "Dunkin Donuts",location: "Lorem Ipsum", description: "lorem",distance: 486,steps: 212,calories: 431),
        //        CoffeeShopStruct(name: "Kenangan Signature",location: "Lorem Ipsum", description: "lorem",distance: 325,steps: 78,calories: 431),
        CoffeeShopStruct(name: "Tabemori",location: "Lorem Ipsum", description: "lorem",distance: 256,steps: 102,calories: 45, latitude: -6.295003167414541, longitude: 106.6675050240924)
        
    ]
    
    var filteredCoffeeshop: [CoffeeShopStruct] {
        guard !searchContent.isEmpty else {
            return coffeeShop
        }
        return coffeeShop
            .filter {
                $0.name.localizedCaseInsensitiveContains(searchContent)
            }
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            if let status = locationManager.authorizationStatus {
                switch status {
                case .notDetermined:
                    Text("Requesting authorization...")
                case .authorizedAlways, .authorizedWhenInUse:
                    Text ("Authorized")
                case .denied, .restricted:
                    Text("Authorization denied.")
                @unknown default:
                    Text("Authorization status unknown.")
                }
            } else {
                Text("Authorization status not yet determined.")
            }
            userProfile()
            HealthDashboardView(viewModel: healthViewModel, isLoading: $isLoading)
            NavigationStack{
                VStack{
                    List(filteredCoffeeshop.sorted(by: {$0.distance < $1.distance})) { shop in
                        Button(action: {
                            selectedCoffeeshop = shop
                            showDetail = true
                        }){
                            HStack{
                                Text(shop.name)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("\(Int(shop.distance)) M")
                                    .foregroundColor(.primary)
                            }
                            
                        }
                        .listRowSeparator(.hidden)
                        
                    }
                    .searchable(text: $searchContent,placement: .navigationBarDrawer(displayMode: .always))
                }
            }
        }.overlay(
            coffeeshopInformation(showDetail: $showDetail, selectedCoffeeshop: $selectedCoffeeshop)
                .animation(.easeInOut, value: showDetail)
        )
        .onAppear{
            locationManager.checkAuthorization()
            if userName.isEmpty {
                showOnboarding = true
            }
        }
        .fullScreenCover(isPresented: $showOnboarding) {
                    OnboardingView()
                }
        .alert(isPresented: $locationManager.showSettingsAlert) {
            Alert(
                title: Text("Location Permission Needed"),
                message: Text("Please enable location access in Settings."),
                primaryButton: .default(Text("Open Settings"), action: {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }),
                secondaryButton: .cancel()
            )
        }
    }
}


//struct userProfile: View {
//    @AppStorage("userName") var userName: String = ""
//    var body: some View {
//        HStack {
//            VStack (alignment: .leading) {
//                Text("Hi, \(userName)!")
//                    .font(.title)
//                    .fontWeight(.semibold)
//                //                    .padding(.vertical)
//                
//                Text("Let’s walk and sip! ☕️")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                    .lineLimit(2)
//            }
//            .padding()
//            Spacer()
//            
//            HStack{
//                Text ("[X] Streak")
//                Image(systemName: "flame.fill")
//            }
//            
//            .padding()
//            .background(Color.brown2)
//            .foregroundColor(.white)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .frame(width: 150, height: 20)
//            .padding(.horizontal)
//        }
////        .fullScreenCover(isPresented: $showOnboarding) {
////            OnboardingView()
////        }
//    }
//}

//struct ContentView: View {
//    @AppStorage("userName") var userName: String = ""
//    
//    var body: some View {
//        if userName.isEmpty {
//            OnboardingView()
//        } else {
//            Homepage()
//        }
//    }
//}

struct userProfile: View {
    @AppStorage("userName") var userName: String = ""
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Hi, \(userName)!")
                    .font(.title)
                    .fontWeight(.semibold)
                //                    .padding(.vertical)
                
                Text("Let’s walk and sip! ☕️")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding()
            Spacer()
            
            HStack{
                Text ("[X] Streak")
                Image(systemName: "flame.fill")
            }
            
            .padding()
            .background(Color.brown2)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: 150, height: 20)
            .padding(.horizontal)
        }
    }
}


#Preview {
    Homepage()
}
