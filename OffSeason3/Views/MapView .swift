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
    let regionSize = 500.0

    // showing sheets
@Environment(\.dismiss) private var dismiss
@State var presentnotificationSheet = false
    @State var presentWeatherSheet = false
    @State var sheetIsPresented = false

    @State var presentHelpSheet = false
    @State var presentfilterSheet = false
    @State var presentCreateSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                mapLayer
                    .ignoresSafeArea()
                if gameVm.isJoiningGame {
                    ExploreCard(game: Game(), player: Player()) .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .bottom)))

                }
                 
            }.toolbar{
                ToolbarItemGroup(placement: .bottomBar) {
                    VStack {
                        HStack(spacing: 12){
                            FilterButton
                            Spacer()
                            CreateButton
                                .offset(x:20,y:-20)
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
        GameDetailsView(game: game, player: Player())
            .presentationDetents([.fraction(0.60)])
            }
        
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack{
                    TestaddingDataView(game: Game())
                    
                }
            }
            .sheet(isPresented: self.$presentfilterSheet){
                filterspage()
                    .presentationDetents([.fraction(0.09)])
              }
            .sheet(isPresented: self.$presentHelpSheet){
          HelpPage()
                  
              }
            
            .sheet(isPresented: self.$presentWeatherSheet){
             WeatherPage()
                   
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
            sheetIsPresented.toggle()
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50)).foregroundColor(.red)
                        .shadow(color: Color.black.opacity (0.4), radius: 20,
                                 x: 0, y: 15)
                }
}

    // new code ⚡️
    var mapLayer : some View{

       Map(coordinateRegion: $mapVm.mapRegion,
           showsUserLocation: true,
           annotationItems: games,
           annotationContent: { location in
           MapAnnotation(coordinate: location.coordinate){
                           // shows what pins are goiing to be on map ↓
                               LocationMapPin()
                           // how to make something bigger if its toggled↓
                               .scaleEffect(mapVm.gameLocation == location ? 1 : 0.7)
                               .onTapGesture {
                                   // how to make the pins touchable and show the location that you tapped ↓
                                   gameVm.selectedGame = location
                                  mapVm.showNextGame(location)
                                   
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
            }.foregroundColor(.black)
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
            self.presentHelpSheet.toggle()
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
            self.presentfilterSheet.toggle()
        }label: {
            Image(systemName: "line.3.horizontal.decrease.circle.fill").font(.system(size: 35)).foregroundColor(.black)
        }
    }
                // new code ⚡️
    var CraftButton: some View {
        Button{
                    self.presentCreateSheet.toggle()
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50)).foregroundColor(.red)
                        .shadow(color: Color.black.opacity (0.4), radius: 20,
                                    x: 0, y: 15)
                }
//                    .offset(y:-25
//                    )
            
        
        
    
    
    
}
    
    
    
    
    
    
    
}
