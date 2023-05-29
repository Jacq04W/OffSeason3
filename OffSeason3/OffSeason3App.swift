//
//  OffSeason3App.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 5/29/23.
//


import SwiftUI
import Firebase
import FirebaseCore

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
    }
//@StateObject var locationManager = LocationManager()
//@StateObject var spotVm = SpotViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
//            LoginView()
//                .environmentObject(spotVm)
//                .environmentObject(locationManager)

                 
        }
    }
}
