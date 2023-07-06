//
//  ExploreCard .swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 6/7/23.
//

import SwiftUI

struct ExploreCard: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var playerVm : PlayerViewModel
    @EnvironmentObject var gameVm : GameViewModel

    // imoport data
    @State var game: Game
    @State var player: Player
    var body: some View {
        NavigationStack {
            VStack(alignment: .center){
                
                Text("Thats wassup! You joined an event \n Continue to explore or go to my Events ")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .bold()
                
                ExploreButton
                
                
                NavigationLink(value: "MyGames") {
                    Button("My Events"){
                        print("Button pressed hh")
                    }
                }
               
                
            }
            .navigationDestination(for: String.self){ view  in
                if view == "MyGames" {
                    Mygames(value:view, game: game)
                }
            }
            .foregroundColor(.black)
            .padding()
            .background(.thickMaterial)
        .cornerRadius(10)
        }
        
    }
    
    
    // code 
    
    var ExploreButton : some View {
    Button {
        withAnimation{
            gameVm.isJoiningGame.toggle()
               
        }
 
    }label:{
        Text("Explore")
            .font(Font.custom("SportSpiritAf", size: 30))
            .frame(width: 133, height: 50)
            .background(.orange)
            .cornerRadius(8)
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .stroke(.black.opacity(0.5))
                    .frame(width: 133, height: 50)
                
                
            )
    }
        
        
//    NavigationLink{
//        MapView()
//    }
//        label : {
//            Text("Explore")
//                .font(Font.custom("SportSpiritAf", size: 30))
//                .frame(width: 133, height: 50)
//                .background(.orange)
//                .cornerRadius(8)
//                .foregroundColor(.black)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(lineWidth: 1)
//                        .stroke(.black.opacity(0.5))
//                        .frame(width: 133, height: 50)
//
//
//                )
//        }
    }
}


struct ExploreCard__Previews: PreviewProvider {
    static var previews: some View {
        ExploreCard(game: Game( name: "Test Run", hostName: "Mike.F", locationName: "LA Fitness", address: "660 Woodward ", category: "BAsketball", summary: "MY kickback come turnuo", description: "This is a pickup game. we are playing 4v4 so make sure yiu have your sqaud with you or find other people to play with spns[dib[sehin]ofewinf]oief]oiwehnf]owhenf]oihwnefoije'ofje]ofj]oefj]eoifh]oeifj[owefjho[weijio]ewhjoiefhjehiw", startDate: Date(), startTime: "12.pm", endTime: "1am`", phoneNumber: "313-472-3545", latitude: 0.0, longitude: 0.0), player: Player())
            .environmentObject(PlayerViewModel())
    }
}
