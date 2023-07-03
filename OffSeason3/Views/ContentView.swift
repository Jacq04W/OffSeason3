//
//  ContentView.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import MapKit
import CoreLocation
import WeatherKit



struct ContentView: View {
    @EnvironmentObject var locationVm : LocationManager
    @EnvironmentObject var mapVm : MapViewModel
    @EnvironmentObject var gameVm : GameViewModel
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    var body: some View {
        NavigationView{
             TabView{
                 
                 Group{
                     MapView(player: Player())
                         .tabItem{
                             Label("Home",systemImage: "house")
                            
                         }
                   ExplorePage()
                         .tabItem{
                             Label("Explore",systemImage: "magnifyingglass")
                             Image(systemName: "")
                         }
                     Mygames()
                         .tabItem{
                             Label("My Games",systemImage: "flag.2.crossed.circle.fill")
                            }
                     
                     ProfilePage(player:Player())
                     
                     .tabItem{
                             Label("Profile",systemImage: "person.crop.circle")
                             
                               
                         }
                     
                 }
                 
                 
                 
                 
                
             }.background(Color.clear)
            

        }
 //            .onAppear {
 //            let appearance = UINavigationBarAppearance()
 //            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
 //            appearance.backgroundColor = UIColor(Color("secondary"))
 //            UINavigationBar.appearance().scrollEdgeAppearance = appearance
 //        }
         
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LocationManager())
            .environmentObject(MapViewModel())
            .environmentObject(GameViewModel())
            .environmentObject(WeatherViewModel())
    }
}
