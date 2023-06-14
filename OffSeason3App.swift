//
//  OffSeason3App.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 5/29/23.
//


import SwiftUI
import Firebase
import FirebaseCore
import WeatherKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct Snacktacku_arApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init(){
        FirebaseApp.configure()
       
        UITabBar.appearance().backgroundColor = UIColor( Color(.black))
        
    }
    
@StateObject var playerVm = PlayerViewModel()
@StateObject var locationManager = LocationManager()
@StateObject var gameVm = GameViewModel()
@StateObject var mapVm = MapViewModel()
@StateObject var weatherVm = WeatherViewModel()

    var body: some Scene {
        WindowGroup {
//            TestPhotos(uiImage: UIImage(named: "temp1") ?? UIImage(), game: Game(), player: Player(), photo: .constant(Photo()))
//            PlaceLookupView(Game:Game())
            LoginView(player: Player())
//            MapView()
                .environmentObject(gameVm)
                .environmentObject(locationManager)
                .environmentObject(mapVm)
                .environmentObject(weatherVm)
                .environmentObject(playerVm)




                 
        }
    }
}
