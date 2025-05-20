import SwiftUI

@main
struct CofficeApp: App {
    @State private var isSplashActive = true
    @AppStorage("userName") var userName: String = ""
    @StateObject var nav = NavigationManager.shared
    @State private var showMapView = false
    @State private var coffeeShops: [CoffeeShopStruct] = coffeeShop

    var body: some Scene {
        WindowGroup {
            if isSplashActive {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isSplashActive = false
                            }
                        }
                    }
            } else {

                NavigationStack {
                    VStack {
                        NavigationLink(
                            destination: SearchListView(
                                showMapView: $showMapView,
                                coffeeShops: coffeeShops
                            ),
                            isActive: $nav.navigateToSearch
                        ) {
                            EmptyView()
                        }


                        if userName.isEmpty {
                            OnboardingView()
                        } else {
                            Homepage()
                        }
                    }
                }
                .onOpenURL { url in
                    if url.absoluteString == "coffice://search" {
                        nav.navigateToSearch = true
                    }
                }
            }
        }
    }
}

