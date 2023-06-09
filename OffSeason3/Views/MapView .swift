//
//  MapView .swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 5/29/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import MapKit
import CoreLocation
import WeatherKit


struct MapView: View {
    // data
    @FirestoreQuery(collectionPath: "games") var games: [Game]
    
    // view models
    @EnvironmentObject var locationVm : LocationManager
    @EnvironmentObject var mapVm : MapViewModel
    @EnvironmentObject var gameVm : GameViewModel
    @EnvironmentObject private var weatherViewModel: WeatherViewModel

// maps
    @State private var mapRegion = MKCoordinateRegion ()
    let regionSize = 10000.0

    // showing sheets
    @State private var showAlert = false

@Environment(\.dismiss) private var dismiss
@State var presentnotificationSheet = false
    @State var presentWeatherSheet = false
    @State var sheetIsPresented = false
    @State var presentHelpSheet = false
    @State var presentfilterSheet = false
    @State var presentCreateSheet = false
    @State var showSignUpSheet = false
    @State var createPlayerSheet = false
    @AppStorage("firstLogin") var firstLogin = true
//    var player : Player

    
    var body: some View {
        NavigationStack {
            ZStack{
                mapLayer
                    .ignoresSafeArea()
                if gameVm.isJoiningGame {
                    ExploreCard(game: Game(), player: Player()) .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .bottom)))

                }
                ZStack{
                    CreateButton
                    .offset(x:150,y:300)
                }
            }
            .task {
                // make map region shows user lo
                mapVm.mapRegion = MKCoordinateRegion(center: locationVm.location?.coordinate  ?? CLLocationCoordinate2D(), latitudinalMeters: regionSize, longitudinalMeters: regionSize)
            }
//            .onAppear{
//                mapVm.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationVm.location?.coordinate.latitude ?? 00 , longitude: locationVm.location?.coordinate.longitude ?? 00 ), span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//                
//                print("appear on home page working ⚡️⚡️⚡️⚡️⚡️")
//            }
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar) {
                    VStack {
                        HStack(spacing: 12){
                            FilterButton
                            Spacer()
                        }.padding(.bottom,30)
                    }
                } 
                
                ToolbarItemGroup(placement: .cancellationAction) {
                    NotificationButton
                    HelpButton
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    HStack(spacing: 2){
                        ActivegamesButton
                        WeatherButton
                        
                    }
                }
            }
            .sheet(item: $gameVm.selectedGame){game in
                NavigationStack{
                    GameDetailsView(game: game, player: Player())
                        
                }.presentationDetents([.fraction(0.60)])
        }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack{
                    TestaddingDataView(game: Game(), player: Player())
                    
                }
            }
            .alert("This feature is not yet available... Stay tuned for the OffSeason V1.1 update \n 🤟🏿⚡️",isPresented: $showAlert){
                Button ("Ok", role: .cancel) {}
                
            }
//            .sheet(isPresented: self.$presentfilterSheet){
//                filterspage()
//                    .presentationDetents([.fraction(0.09)])
//              }
            .sheet(isPresented: self.$presentHelpSheet){
          HelpPage()
                  
              }
            .sheet(isPresented: self.$presentWeatherSheet){
             WeatherPage()
                   
            }
            .sheet(isPresented: $createPlayerSheet){
                SignUpPage(player:Player())
                      
               }
            .sheet(isPresented: self.$presentnotificationSheet){
               NotificationPage()
                
            }

        }
//
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(LocationManager())
            .environmentObject(MapViewModel())
            .environmentObject(GameViewModel())
            .environmentObject(WeatherViewModel())



    }
}
 


 
private extension MapView {
    // new code ⚡️
    var CreateButton: some View {
        Button{
//            sheetIsPresented.toggle()
//            createPlayerSheet.toggle()

            if firstLogin{
                 createPlayerSheet.toggle()
                 firstLogin = false

            } else {
                sheetIsPresented.toggle()
            }
                }label: {
                    ZStack{
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 50, height: 50)
                        Image(systemName: "plus.circle.fill")
                .font(.system(size: 65)).foregroundColor(.red)
                            .shadow(color: Color.black.opacity (0.4), radius: 20,
                                    x: 0, y: 15)
                    }
                }
}
   
    // new code ⚡️ 
    var mapLayer : some View{

       Map(coordinateRegion: $mapVm.mapRegion,
           showsUserLocation: true,
           annotationItems: games,
           annotationContent: { location in
           MapAnnotation(coordinate: location.coordinate){
                               FootBallMapPin()
            .scaleEffect(mapVm.gameLocation == location ? 1 : 0.7)
                        .onTapGesture {

                        if  firstLogin{
                        showSignUpSheet.toggle()
                            } else {
                gameVm.selectedGame = location
                mapVm.showNextGame(location)
                            }
                                
                        }
                       }
                   })
        
        
        
    }
    
    // new code ⚡️
    var NotificationButton:  some View {
        Button(action: { self.presentnotificationSheet.toggle() }) {
            Image(systemName: "bell.circle.fill").font(.system(size: 35))
                .foregroundColor(.blue)
                .shadow(color: Color.black.opacity (0.4), radius: 20,
                         x: 0, y: 15)
            
        }
        
    }
    // new code ⚡️
    var ActivegamesButton: some View {
        Button{
            
        }label: {
            HStack {
                Image(systemName: "figure.run.circle.fill")
                Text("Active:")
                Text("\(games.count)")
            }.font(.title3)
                .bold()
        }.buttonStyle(.plain)
            .padding()
            .frame(width: 160,height: 40)
            .background(.thinMaterial)
            .cornerRadius(90)
            .shadow(color: Color.black.opacity (0.4),
                    radius: 20, x: 0, y: 15)
    }
    
    // new code ⚡️
    var WeatherButton: some View {
        Button{
            self.presentWeatherSheet.toggle()
        }label: {
            HStack{
                Image(systemName: "cloud")
                
                    .bold()
                Text(weatherViewModel.currentTemperature.dropLast()).font(.system(size: 17))
                    .foregroundColor(.black)
            } 
                .buttonStyle(.plain)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(.thinMaterial).cornerRadius(90)
                .shadow(color: Color.black.opacity (0.4), radius: 20,
                         x: 0, y: 15)
        }.buttonStyle(.plain)
//        Text(weatherViewModel.currentTemperature.dropLast())
//            .font(.system(size:72))
//            .fontWeight(.light)
        
    }
        
    // new code ⚡️
    var HelpButton: some View {
        Button{
            showAlert.toggle()

//            self.presentHelpSheet.toggle()
        }label: {
            ZStack{
                Circle()
                    .frame(width: 50, height: 45)
                    .foregroundColor(.red)

                Image(systemName: "cross.case").font(.system(size: 20))
//                    .fill(.ultraThinMaterial)
                    .foregroundColor(.white)
            }
             
        }.shadow(color: Color.black.opacity (0.4), radius: 20,
                 x: 0, y: 15)
    }
    
    // new code ⚡️
    var FilterButton: some View {
        Button{
            showAlert.toggle()
//            self.presentfilterSheet.toggle()
        }label: {
            Image(systemName: "line.3.horizontal.decrease.circle.fill").font(.system(size: 35)).foregroundColor(.black)
        }
    }
    // new code ⚡️
    
    
    
    
    
    
    
}
