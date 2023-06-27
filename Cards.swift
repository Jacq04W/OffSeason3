//
//  Cards.swift
//  OffSeason3
//
//  Created by Jacquese Whitson on 6/27/23.
//

import SwiftUI
import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

struct Cards: View {
    @State var game : Game
    var body: some View {

        ZStack {
            Image("cover1")
                .resizable()
            VStack(alignment: .leading){
                HStack{
                    VStack{
                        Text(game.name)
                        
                            .bold()
                            .font(.system(size: 15))
//                            .lineLimit(2)
//                            .padding(.trailing, 50.0)
                        Text(game.locationName)
                            .bold()
                            .font(.system(size: 10))

                            .lineLimit(1)
                            .font(.subheadline)
                    }
                    .padding(.bottom)
                            Spacer()
                }
                .padding()
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
            .frame(height: 90)
            .background(.thinMaterial)
            .cornerRadius(20)
            .offset(y:80)
        }
            .frame(width:150,height: 190)
        .aspectRatio(contentMode: .fill)
        .cornerRadius(20)

        
    }
}

struct Cards_Previews: PreviewProvider {
    static var previews: some View {
        Cards(game: Game( name: "Test Run pt2", hostName: "Mike.F", locationName: "LA Fitness", address: "660 Woodward ", category: "BAsketball", summary: "MY kickback come turnuo", description: "This is a pickup game. we are playing 4v4 so make sure yiu have your sqaud with you or find other people to play with spns[dib[sehin]ofewinf]oief]oiwehnf]owhenf]oihwnefoije'ofje]ofj]oefj]eoifh]oeifj[owefjho[weijio]ewhjoiefhjehiw", startDate: Date(), startTime: "12.pm", endTime: "1am`", phoneNumber: "313-472-3545", latitude: 0.0, longitude: 0.0)
              )
    }
}
