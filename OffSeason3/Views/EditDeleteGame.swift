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
    
    var body: some View {
        NavigationStack {
            VStack{
        // maybe a multitude of pics
        // TODO: this should be event.coverPhoto
        Image("cover2")
            .resizable()
            .scaledToFill()
            .frame(width: 350, height: 113)
            .cornerRadius(21)
            .offset(y:-20)

        HStack{
            VStack{
                Text(game.name )
                    .font(.system(size: 25))
                    .offset(y:-10)
                    .bold()
                HStack{
                    Image(systemName: "calendar")
                    Text("\(game.startDate)")
                        .lineLimit(1)
                    Text("✘12:00 PM")
                }
                .font(.system(size: 25))

                HStack(spacing:1){
                    Image(systemName: "mappin")
                        .foregroundColor(.gray)
                    Text(game.address)
                } .font(.system(size: 25))
    //                        .offset(y:13)

                .padding(.trailing,10)
            }
            .overlay(
                Text("$50")
        .font(.system(size: 25))
        .offset(x:140,y:30)
        .bold()
    )
        }
        .background(
        infoCard)
//        .offset(y:-20)

                    .padding()
        .background{
//            infoCard
        }
        .offset(y:15)
    }.background{
        bigCard
        
}
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
                nextButton
            }
            
           
            
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
                .frame(width: 376, height: 217)
            
        }
        .overlay{
            Button{
                //Todo: Alow discard event
            }
        label:{
            Image(systemName: "x.circle.fill")
                .offset(x: 170, y: -145)
                .font(.system(size: 48))
                .foregroundColor(.black)
        }
            
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
    var nextButton : some View{
        Button{
            withAnimation{

            }
        }
    label:{
        ZStack{
            RoundedRectangle(cornerRadius: 9)
                .frame(width: 72, height: 36)
                .foregroundColor(.orange)
            VStack{
                Text("Edit")
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
//                    showErrorAlert.toggle()
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
                                .foregroundColor(.black)
                            
                        }
                    }
                }
            }
        }
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

    // new code

    // new code

    // new code

    

}
