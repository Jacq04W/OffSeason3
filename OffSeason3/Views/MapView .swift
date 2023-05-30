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


struct MapView: View {
    // how to put the collection of data from firebase into a variable
    @FirestoreQuery(collectionPath: "games") var games: [Game]
    @Environment(\.dismiss) private var dismiss
     @State private var sheetIsPresented = false
    @EnvironmentObject var locationVm : LocationManager
    @EnvironmentObject var mapVm : MapViewModel
    @EnvironmentObject var gameVm : GameViewModel

    @State private var mapRegion = MKCoordinateRegion ()
    let regionSize = 500.0


    
    var body: some View {
        NavigationStack {
            VStack{
//                List(games){game in
//                    NavigationLink{
//                        GameDetailsView(game: game)
//                    } label: {
//                        Text(game.name)
//
//                    }
//                }
//
                mapLayer
                    .ignoresSafeArea()
                
                
                Text("Location : \(locationVm.location?.coordinate.latitude ?? 0.0), \(locationVm.location?.coordinate.longitude ?? 0.0 ) ")
                
                
                 
            }
            //            List(spots){spot in
            //                NavigationLink{
            //                    SpotDetailView(spot: spot)
            //                }
            //            label:{
            //                Text(spot.name)
            //                    .font(.title2)
            //            }
            //            }
            //            .listStyle(.plain)
            //            .navigationTitle("Snack Spots")
            //            .navigationBarTitleDisplayMode(.inline)
            
    .sheet(item: $gameVm.selectedGame){game in
        GameDetailsView(game: game)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Sign Out"){
                        do {
                            try Auth.auth().signOut()
                            print("🪵⏩ log out successful ")
                            dismiss()
                        } catch{
                            print("🤬 Error: Could sign out")
                        }
                    }
                }
                ToolbarItemGroup(placement: .bottomBar){
                    Spacer()
                CreateButton
                    
                    
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack{
                    TestaddingDataView(game: Game())
                    
                }
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


    }
}




private extension MapView {
    var CreateButton: some View {
        Button{
            sheetIsPresented.toggle()
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50)).foregroundColor(.red)
                        .shadow(color: Color.black.opacity (0.4), radius: 20,
                                 x: 0, y: 15)
                }
//                    .offset(y:-25
//                    )
            
        
        
    
    
    
}

    
    
    var mapLayer : some View{

       Map(coordinateRegion: $mapVm.mapRegion,
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
    
    
    
    
    
    
    
    
}
