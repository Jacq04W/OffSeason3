//
//  Mygames.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

struct Mygames: View {
    var value : String?
    @State var choice = 3
    @FirestoreQuery(collectionPath: "games") var games : [Game]
    @State var game : Game
     var body: some View {
             NavigationStack {
                 VStack {
//                     if game.posterEmail == Auth.auth().currentUser?.email{
                         List{
                         ForEach(games) { game in
                           
listRowView(game: game)                             }
                         }
//                     }
//                     else {
//                         emptyTickets
//                             .ignoresSafeArea()
//                     }
                     
                 }
                .navigationTitle("My Games")
//                .navigationDestination(for: Game.self) { game in
//                    mapView
//                }
                
            }
        
        }
    }


struct Mygames_Previews: PreviewProvider {
    static var previews: some View {
        Mygames(game:Game())
    }
}


private extension Mygames {
    var emptyTickets : some View {
        // creating background for this page
        VStack {
            ZStack {
                
//                Color(red: 0.11, green: 0.11, blue: 0.114)
                // create graphics
                ZStack{
                    Circle()
                        .frame(width: 150, height: 130, alignment: .center)
                        .foregroundColor(Color(red: 0.173, green: 0.173, blue: 0.177))
                        .padding(.bottom,90)
                    Image(systemName: "gamecontroller")
                        .resizable()
//                        .foregroundColor(Color(red: 0.325, green: 0.325, blue: 0.33))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 40)
                        .padding(.bottom,90)
                    
                }
                .offset(y:-100)

                // words on the screen
                VStack(spacing:10){
                    Text("No games yet")
                        .font(Font.custom("SportSpiritAf", size: 40))
                        .foregroundColor(.red)
                        
                        .fontWeight(.bold)
                    Text("Choose a way to get active ")
                        .lineLimit(1)
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                    
                    Text("Join or create an event of your own")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                }
                .offset(y:0)
                
                // footer
                VStack{
                    // some live events
                    Text("See what's up with live games near you ")
                        .foregroundColor(.gray)
                        .bold()
//                        .offset(y:250)
                    
                    NavigationLink{
                        MapView()
//                        showGames.toggle()
                    } label: {
                        Text("See games")
                            .frame(width: 150,height:50)
                            .background(Color(hue: 1.0, saturation: 0.929, brightness: 0.898))
                            .font(Font.custom("SportSpiritAf", size: 25))
                            .foregroundColor(.white).fontWeight(.bold)
                            .buttonStyle(.bordered)
                            .cornerRadius(10)
                        
                        // have some one fix shadow here
//                          .shadow(color: .black.opacity(0.6), radius: 7,x:14,y:-2)
                    }
//                    .offset(y:250)
                    
                }
                .offset(y:140)

            }
                    }
        .navigationTitle("My Games")
        
    }
    private func listRowView(game: Game) -> some View  {
        HStack {
//            if let imageName = game.imageNames.first {
//                Image(imageName)
//                    .resizable()
//                    .scaledToFill()
//            .frame(width: 95, height: 95)

//                    .frame(width: 45, height: 45)
//                    .cornerRadius(10)
//            }
            
            
          Image("cover1")
                .resizable()
                .frame(width: 95, height: 95)
                .cornerRadius(15)

            
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(Font.custom("SportSpiritAf", size: 30))

//                    .font(.headline)
                HStack(spacing: -1){
                    Image(systemName: "mappin")
                    Text(game.locationName)
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    
    
    
    
//    func fetchEvents() {
//            let currentUserID = Auth.auth().currentUser?.uid
//            
//            Firestore.firestore().collection("events")
//                .whereField("creatorID", isEqualTo: currentUserID)
//                .getDocuments { (snapshot, error) in
//                    if let error = error {
//                        print("Error fetching events: \(error.localizedDescription)")
//                        return
//                    }
//                    
//                    guard let documents = snapshot?.documents else {
//                        print("No events found")
//                        return
//                    }
//                    
//                    let fetchedEvents = documents.compactMap { snapshot in
//                        try? snapshot.data(as: Event.self)
//                    }
//                    
//                    self.events = fetchedEvents
//                }
//        }
    

}
