//
//  ExplorListCard.swift
//  OffSeason3
//
//  Created by Jacquese Whitson on 6/21/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit
struct ExplorListCard: View {
    @FirestoreQuery(collectionPath: "games") var games: [Game]
    
    // view models
    @EnvironmentObject var locationVm : LocationManager
    @EnvironmentObject var mapVm : MapViewModel
    @EnvironmentObject var gameVm : GameViewModel
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
   @State var game: Game
    
    var body: some View {
        ZStack{
            Image("cover2")
                .resizable()
                .cornerRadius(30)
                .aspectRatio(3/3, contentMode: .fit)
                .frame(width: 200, height: 200)
            
                       VStack(alignment: .leading){
                Text("game.name")
                .font(Font.custom("SportSpiritAf", size: 30))
                .lineLimit(1)
            }
            .frame(width: 200,height: 50)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .offset(y:85)
        }
        .onTapGesture {
            
        }
    }
}

struct ExplorListCard_Previews: PreviewProvider {
    static var previews: some View {
        ExplorListCard(game:Game())
            .environmentObject(LocationManager())
            .environmentObject(MapViewModel())
            .environmentObject(GameViewModel())
            .environmentObject(WeatherViewModel())
    }
}
