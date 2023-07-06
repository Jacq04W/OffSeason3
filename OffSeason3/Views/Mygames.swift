//
//  Mygames.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI
import Firebase
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
                     
                     if game.posterEmail == Auth.auth().currentUser?.email{
                         ForEach(games) { game in
                             GameDetailCard(game: game)
                             
                         }
                     }
                     else {
                         emptyTickets
                             .ignoresSafeArea()
                     }
                     
                 }
                .navigationTitle("My Games")
                
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
                    Image(systemName: "ticket")
                        .resizable()
                        .foregroundColor(Color(red: 0.325, green: 0.325, blue: 0.33))
                        .frame(width: 50, height: 40)
                        .padding(.bottom,90)
                    
                }
                .offset(y:-50)

                // words on the screen
                VStack(spacing:10){
                    Text("No games yet")
                        .font(Font.custom("SportSpiritAf", size: 40))
                        .foregroundColor(.red)
                        
                        .fontWeight(.bold)
                    Text("Make sure you're in the same account that")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                    
                    Text("You joined your game on")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                }
                .offset(y:20)
                
                // footer
                VStack{
                    // some live events
                    Text("See whats up with live games near you ")
                        .foregroundColor(.gray)
                        .bold()
//                        .offset(y:250)
                    
                    NavigationLink{
                        MapView(player: Player())
//                        showGames.toggle()
                    } label: {
                        Text("See games")
                            .frame(width: 150,height:50)
                            .background(Color(hue: 1.0, saturation: 0.929, brightness: 0.898) )
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .buttonStyle(.bordered)
                            .cornerRadius(10)
                        
                        // have some one fix shadow here
//                          .shadow(color: .black.opacity(0.6), radius: 7,x:14,y:-2)
                    }.disabled(true)
//                    .offset(y:250)
                    
                }
                .offset(y:220)

            }
                    }
        .navigationTitle("My Games")
        
    }

}
