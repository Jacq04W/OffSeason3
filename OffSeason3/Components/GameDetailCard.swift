//
//  GameDetailCard.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 6/17/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

struct GameDetailCard: View {
    var game: Game
    @FirestoreQuery(collectionPath: "games") var games: [Game]
    
    var body: some View {
        ZStack{
            purpleCard
            VStack{
                coverPhoto
                ZStack{
                    frostBackground
                        .offset(y:10)
                    gameInfo
                }
            }
            
            
        }
        
    }
}

struct GameDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailCard(game: Game( name: "Test Run", hostName: "Mike.F", locationName: "LA Fitness", address: "660 Woodward ", category: "BAsketball", summary: "MY kickback come turnuo", description: "This is a pickup game. we are playing 4v4 so make sure yiu have your sqaud with you or find other people to play with spns[dib[sehin]ofewinf]oief]oiwehnf]owhenf]oihwnefoije'ofje]ofj]oefj]eoifh]oeifj[owefjho[weijio]ewhjoiefhjehiw", startDate: Date(), startTime: "12.pm", endTime: "1am`", phoneNumber: "313-472-3545", latitude: 0.0, longitude: 0.0))
    }
}


private  extension GameDetailCard {
    // new code
    var coverPhoto : some View {
        VStack{
            Image("cover2")
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 113)
                .cornerRadius(21)
                .offset(y:-20)
            
        }
    }
    // new code

    var purpleCard : some View
    {
        VStack{
            RoundedRectangle(cornerRadius: 21)
                .fill(LinearGradient(gradient: Gradient(colors: [Color("purp"), Color("wok")]), startPoint: .topLeading, endPoint: .bottom) )
                .frame(width: 370, height: 217)
            
        }
       
    }
    
    // new code
    var frostBackground : some View {
        VStack {
            ZStack{
                RoundedRectangle(cornerRadius: 21)
                    .stroke(Color(red: 0.545, green: 0.545, blue: 0.588))
                    .frame(width: 350, height: 100)
                    .offset(y:-25)
                
                
                RoundedRectangle(cornerRadius: 21)
                    .fill(.ultraThinMaterial )
                    .frame(width: 350, height: 100)
                
                
                    .offset(y:-25)
                
            }
        }
    }


    // new code
    var gameInfo : some View  {
    VStack{
        Text(game.name )
            .lineLimit(1)
            .font(Font.custom("SportSpiritAf", size: 35))
            .offset(y:-10)
        HStack{
            let gameDay = game.startDate.formatted(date:.abbreviated,time:.omitted)
            
            Image(systemName: "calendar")
            Text("\(gameDay)")
                .font(.system(size: 25))
                .lineLimit(1)
            Text("✘12:00 PM")
        }            .offset(y:-10)

        .font(.system(size: 25))
        
        HStack(spacing:1){
            Image(systemName: "mappin")
                .foregroundColor(.black)
            Text(game.locationName)
                .lineLimit(1)
            //TODO: create tickets
//            Text("$50")
//                .font(Font.custom("SportSpiritAf", size: 29))
//                .offset(x:25)
//                .bold()
            
        } .font(.system(size: 25))
            .offset(y:-10)

        //
    }
}

    // new code

    // new code

    // new code

    // new code

    // new code

    

    
}
