//
//  EventDetailsView.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 5/29/23.
//

//
//
//
//  Created by Rheyya Hollins on 5/18/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

struct GameDetailsView: View {
    // put in own file
    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject private var locationVm : LocationManager
//    @EnvironmentObject private var mapVm : MapViewModel
//    @EnvironmentObject private var eventVm : EventViewModel
//
    // imoport data
    @State var game: Game
    @State var player: Player

    @EnvironmentObject var playerVm : PlayerViewModel

    @EnvironmentObject var gameVm : GameViewModel
    @FirestoreQuery(collectionPath: "games") var games : [Game]
    @FirestoreQuery(collectionPath: "games") var players : [Player]

    @Environment(\.dismiss) private var dismiss
@State private var showAlert = false
    @State private var noJoin = false
    @State private var postedByThisUser = false
var 😎 = "OKKKK"
    var body: some View {
            
        NavigationStack {
            ZStack {
            ScrollView{
                        VStack {
                            gameName
                            VStack(alignment:.leading){
                                locationName
                                startDate
                                 hostName
                        
                                VStack(spacing: 20) {
                                    HStack(spacing:25){
                                        directionsButton
                                        hoursButton
                                        moneyButton
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    Divider()
                                    
                                    // images here
    //
    //                                SpotDetailPhotosScrollView(photos: photos, event: event, player: player)

                                    ScrollView(.horizontal) {
                                        HStack{
                                            Image("cover2")
                                                .resizable()
                                            .scaledToFill ()
                                                .frame(width: 120, height:120)
                                                .clipped()
                                            
                                            Image("cover2")
                                                .resizable()
                                                .scaledToFill ()
                                                .frame(width: 120, height:120)
                                                .clipped()
                                            
                                            Image("cover2")
                                                .resizable()
                                                .scaledToFill ()
                                                .frame(width: 120, height:120)
                                                .clipped()
                                            Image("cover2")
                                                .resizable()
                                                .scaledToFill ()
                                                .frame(width: 120, height:120)
                                                .clipped()
                                        }
                                    }
                                    .cornerRadius(10)
                                }
                                
                        
                                Text("Details")
                                    .bold()
                                    .font(.title)
                                    Divider()
                                
                                Text(game.description)
                                .padding()
                                .frame(width: 360,alignment: .topLeading)
                                .background(.ultraThinMaterial)
                                .cornerRadius(20)
                                    
                                
                                Text("Joined Players")
                                    .bold()
                                    .font(.title)
                                Divider()
                                //TODO: GOOD TO KNOW FORM
                                ForEach(players) { player in
                                    //TODO: fix the freame on this when ther are no players
                                    
                                    VStack{
                                        Text(player.userName)
                                            .padding()
                                            .frame(height: 360,alignment: .topLeading)
                                            
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(20)
                                    }
                                }
                                
                                
                    
                            }.padding(.leading)
                            
                            VStack{
                                Text("Ratings & Reviews")
                                    .bold()
                                    .font(.title)
                                Divider()
       //TODO: Joined player cards
    //                            Text("ok")
    //                            .padding()
    //                            .frame(width: 360, height: 250,alignment: .topLeading)
    //                            .background(.ultraThinMaterial)
    //                            .cornerRadius(20)
                            }
                               
                        }
                        .alert("This feature is not yet available on this version... stay tuned for the  OffSeason V1.1 update 🤟🏿⚡️",isPresented: $showAlert){
                            Button ("Ok", role: .cancel) {}
                            
                        }
                        .alert("Can not join an event you created ma baby 🤟🏿⚡️ ",isPresented: $noJoin){
                            Button ("Ok", role: .cancel) {}
                            
                        }
                        .toolbar{
    //                        if postedByThisUser{
    //
    //
    //
    //
    //                        }
                    ToolbarItemGroup(placement: .confirmationAction) {
                              favoriteButton
                                xButton
                                }
                        }
                        
        
                    }
                    ZStack{
                        VStack {
                        Spacer()
                           joinGame
                    }
                }
            }
        }
//                .onAppear{
//            // if crash ch8.12 @ 7min
//    $games.path = "games/\(game.id ?? "")/players"
//                    print("The games Path \($games.path)")
//        }
            
       
    }
}


    struct LaFitness: PreviewProvider {
        static var previews: some View {
            GameDetailsView(game: Game( name: "Test Run", hostName: "Mike.F", locationName: "LA Fitness", address: "660 Woodward ", category: "BAsketball", summary: "MY kickback come turnuo", description: "This is a pickup game. we are playing 4v4 so make sure yiu have your sqaud with you or find other people to play with spns[dib[sehin]ofewinf]oief]oiwehnf]owhenf]oihwnefoije'ofje]ofj]oefj]eoifh]oeifj[owefjho[weijio]ewhjoiefhjehiw", startDate: Date(), startTime: "12.pm", endTime: "1am`", phoneNumber: "313-472-3545", latitude: 0.0, longitude: 0.0), player: Player())
//                .environmentObject(LocationManager())
//                .environmentObject(MapViewModel())
                .environmentObject(GameViewModel())
                .environmentObject(PlayerViewModel())

//                .environmentObject(WeatherViewModel())
        }
    }



 














private extension GameDetailsView {
    var directionsButton: some View {
        // new code⚡️
        Button{
            showAlert.toggle()
//            presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack{
        RoundedRectangle(cornerRadius: 30)
                    .fill(.black)
                    .frame(width: 92, height: 32)

                Image(systemName: "car")
                    .font(.title)
            }
        }
    }
    // new code⚡️
    var hoursButton: some View {
        // new code⚡️
        Button{
            showAlert.toggle()

//            presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack{
        RoundedRectangle(cornerRadius: 30)
                    .fill(.black)
                    .frame(width: 92, height: 32)

                Image(systemName: "clock")
                    .font(.system(size: 25))
                    .font(.title)
            }
        }
    }
    
    // new code⚡️
    var moneyButton: some View {
        // new code⚡️
        Button{
            showAlert.toggle()

        } label: {
            ZStack{
        RoundedRectangle(cornerRadius: 30)
                    .fill(.black)
                    .frame(width: 92, height: 32)

                Image(systemName: "dollarsign")
                    .font(.body)
            }
        }
    }
    
    // new code⚡️
    var favoriteButton : some View {
        Button(action: {
//            presentationMode.wrappedValue.dismiss()
            showAlert.toggle()
        }, label: {
            Image(systemName: "heart")
                .foregroundColor(.red)
                .font(.title)
            
        })
    }
    
    // new code⚡️
    var xButton : some View  {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .font(.title)
            
    })
    }
    
    // new code⚡️
    var locationName : some View {
        HStack{
            Image(systemName: "mappin")
                .foregroundColor(.gray)
                .font(.system(size: 20))
            
            Text(game.locationName)
                .lineLimit(1)
                .textSelection(.enabled)
                .font(.title2)
                .bold()
        }        .font(.system(size: 20))
    }
    
    // new code⚡️
    var startDate : some View {
        HStack{
            Image(systemName: "calendar")            .foregroundColor(.gray)

            
            Text("\(game.startDate.formatted(date: .numeric, time: .omitted))")
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            //                                    .font(.title2)
        }
        
            .font(.system(size: 20))
    }
    
    // new code⚡️
    var hostName : some View {
        HStack{
            Image(systemName: "person")            .foregroundColor(.gray)

               
            //TODO: maybe change this to the player.name
            Text("\(game.hostName)")
        }.padding(.bottom)
            .bold()
            .font(.system(size: 20))
    }
    
    // new code⚡️
    var gameName : some View {
        Text(game.name)
            .lineLimit(1)
            .font(Font.custom("SportSpiritAf", size: 30))
            .bold()
            .font(.title)
    }
    
    // new code⚡️
    var joinGame : some View {
        Button{
        //    if Auth.auth().currentUser?.email == game.posterEmail {
        //        noJoin.toggle()
            
        //    }
        //    else {
                withAnimation {
                    
                    //TODO: if the current user match the use rwho psoted the event disable the button
                    Task{
                        let success = await playerVm.addPlayer(game: game, player: player)
                        if success {
                            dismiss()
                        } else {
                            print("🤬 Error: joining game")
                        }
                    }
                    
                    gameVm.isJoiningGame.toggle()
                }
               
                
            //}
          
            
        }
    label:{
        Text("Join Game")
            .bold()
            .font(Font.custom("SportSpiritAf", size: 45))            .foregroundColor(.white)
            .frame(width: 350, height: 70)
            .background(.red)
            .clipShape(Capsule())
        
    }
//    .disabled(Auth.auth().currentUser?.email == player.email)
    }
    
    // new code⚡️

    
    // new code⚡️

    
    
    // new code⚡️

    
    
    
    // new code⚡️

    
    
    // new code⚡️

    
    
    // new code⚡️

    
    
}
