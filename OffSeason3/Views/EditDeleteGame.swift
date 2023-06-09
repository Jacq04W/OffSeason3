//
//  EditDeleteGame.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 6/11/23.
//

import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

struct EditDeleteGame: View {
    // data
    var game: Game
    @FirestoreQuery(collectionPath: "games") var games: [Game]
    
    // view models
    @EnvironmentObject var locationVm : LocationManager
    @EnvironmentObject var mapVm : MapViewModel
    @EnvironmentObject var gameVm : GameViewModel
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    
    
    // ImagePicker items
    @State var image: UIImage?
    @State var newPhoto =  Photo()
    @State private var selectedPhoto: PhotosPickerItem?
    @State var shouldShowImagePicker = false
    @State private var uiImageSelected = UIImage()
    @State private var showPhotoViewSheet = false

    
    // misc
    @Environment(\.dismiss) private var dismiss
    @State private var confirmDelete = false
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    
                    GameDetailCard(game: game)
                        .onTapGesture {
                        gameVm.selectedGame = game

                        }
                        .overlay{
                            Button{
            //TODO: CHeck this
                                confirmDelete.toggle()
                                
                               
                                
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.black)
                                                      }
                            .offset(x:160,y:-130)
                        }
                        
                    
                }.padding()
               
              
            }

            // TODO: finish adding images here 
            ZStack{
                VStack{
                    Spacer()

                    photoPicker
                }
            }  .navigationTitle("Confirm Details")
    
            .toolbar{
                ToolbarItemGroup(placement: .primaryAction) {
                    Button{
                        
                    }label: {
                        filterButton
                    }
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    Button{
                        
                    }label: {
                        postButton
                    }
                    
                }
                
        }
            .alert("This feature is not yet available... stay tuned for the  OffSeason V1.1 update \n 🤟🏿⚡️",isPresented: $showAlert) {
                    Button ("Ok", role: .cancel) {}
                    
                }
                .alert("Are you sure you want to delete this game?",isPresented: $confirmDelete) {
                    Button ("No", role: .cancel) {}
                    Button ("Yes", role: .destructive) {
                        Task{
                            let success =
                            await  gameVm.deleteReview(game: game)
                            if success {
                                dismiss()
                            }
                        }
                    }
                    
            }
                .sheet(item: $gameVm.selectedGame){game in
                    NavigationStack{
                        GameDetailsView(game: game, player: Player())
                        
                    }
                }


        }
       
   
    }
    
}

struct EditDeleteGame_Previews: PreviewProvider {
    static var previews: some View {
        EditDeleteGame(game:  Game( name: "Test Run", hostName: "Mike.F", locationName: "LA Fitness", address: "660 Woodward ", category: "BAsketball", summary: "MY kickback come turnuo", description: "This is a pickup game. we are playing 4v4 so make sure yiu have your sqaud with you or find other people to play with spns[dib[sehin]ofewinf]oief]oiwehnf]owhenf]oihwnefoije'ofje]ofj]oefj]eoifh]oeifj[owefjho[weijio]ewhjoiefhjehiw", startDate: Date(), startTime: "12.pm", endTime: "1am`", phoneNumber: "313-472-3545", latitude: 0.0, longitude: 0.0))
            .environmentObject(LocationManager())
            .environmentObject(MapViewModel())
            .environmentObject(GameViewModel())
            .environmentObject(WeatherViewModel())
    }
}

private extension EditDeleteGame {
    
    
    // new code
    var bigCard : some View
    {
        VStack{
            RoundedRectangle(cornerRadius: 21)
                .fill(LinearGradient(gradient: Gradient(colors: [Color("purp"), Color("wok")]), startPoint: .topLeading, endPoint: .bottom) )
                .frame(width: 370, height: 217)
            
        }
       
    }
    
    // new code
    var infoCard : some View {
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
    var postButton : some View{
        Button{
//                showAlert.toggle()
                Task{
                    let success = await
                    gameVm.saveGame(game: game)
                    if success {
                        dismiss()
                    }
                    else {
                        print("🤬Error: Couldnt save Game")
                    }
                }

            
        }
    label:{
        ZStack{
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 72, height: 36)
                .foregroundColor(Color("purp"))
            VStack{
                Text("Post")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
    }
    
    
    // new code
    var filterButton : some View{
        VStack{
            Button{
                withAnimation{
                    showAlert.toggle()
                }
            }
        label:{
            ZStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 9)
                        .fill(
                        
                            .thickMaterial)
                        .frame(width: 110, height: 36)
                        
//                        .foregroundColor(.gray)
                    VStack{
                        HStack{
                            
                            Image(systemName: "globe")
                                .font(.system(size: 13))
                            Text("Anyone")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                        }                        .foregroundColor(.black)

                    }
                }
            }
        }.buttonStyle(.plain)
            
        }
    }
    // new code

    var addPhotosButton : some View {
        VStack{
            PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic){
                HStack{Image(systemName: "photo")
                    Text ("Photo" )
                }
                .padding()                 .frame(height:40)

                .foregroundColor(.black)
                .background(.orange)
                .cornerRadius(10)
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
            Text("✘✘✘")
        }
        .font(.system(size: 25))
        
        HStack(spacing:1){
            Image(systemName: "mappin")
                .foregroundColor(.gray)
            Text(game.locationName)
                .lineLimit(1)
            //TODO: create tickets
//            Text("$50")
//                .font(Font.custom("SportSpiritAf", size: 29))
//                .offset(x:25)
//                .bold()
            
        } .font(.system(size: 25))
        //
    }
}

    // new code
    var coverPhoto : some View {
        VStack{
            Image("cover2")
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 113)
                .cornerRadius(21)
                .offset(y:-20)
            
        } .overlay{
            Button{
                //Todo: Allow discard event
                confirmDelete.toggle()
                
            }
        label:{
            Image(systemName: "x.circle.fill")
                .offset(x: 168, y: -65)
                .font(.system(size: 48))
                .foregroundColor(.black)
        }
            
        }
    }
    // new code
    var photoPicker :some View  {
        VStack{
            PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic){
                HStack{Image(systemName: "photo")
                    Text ("Add More Photos" )
                }
                .padding()
                .frame(width:350,height:60)
                
                .foregroundColor(.black)
                .background(.thickMaterial)
                .cornerRadius(10)
            }
        }
    }


    // new code

    

}
