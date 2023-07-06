//
//  ExplorePage.swift
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
 

struct ExplorePage: View {
    @FirestoreQuery(collectionPath: "games") var games : [Game]
    
    var tests = [Player( firstName: "MIke", lastName: "The Rec Center", userName: "HBLHJB", email: "", age: Date(), gender: ""),
                 Player( firstName: "Jacq", lastName: "The Rec Center", userName: "HBLHJB", email: "", age: Date(), gender: "")
    
    ]
    let columns: [GridItem] = [
        GridItem(.flexible(),spacing: 6,alignment: nil),
        GridItem(.flexible(),spacing: 6,alignment: nil),

    ]
    
    @State private var filters: [Filter] = [
        Filter(name: "All", image: "basketball.fill"),

    Filter(name: "Basketball", image: "basketball.fill"),
    Filter(name: "Football", image: "football.fill")
,    Filter(name: "Chess", image: "basketball.fill")
,    Filter(name: "Soccer", image: "basketball.fill")
    ]
    
      
    var body: some View {
        NavigationStack{
            ScrollView {
            VStack(alignment: .leading){
                    Text("Categories")
                        .font(.title2)
                        .bold()
              
                ScrollView(.horizontal,showsIndicators: false){
                    HStack {
           
                            
                            ForEach(filters,id: \.name) { filter in
                                
                                Button{}
                            label:{
                                Text(filter.name)
                                    .lineLimit(1)
                                    .font(.caption)
                                    .bold()
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(30)
                            }.buttonStyle(.plain)
                                
                            }
                    }
                 }
                
                    Spacer()
                    
                }.padding()
                
                
                VStack {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 4, pinnedViews: []) {
                        Section(header:
                                    HStack{Text("All Games")
                                .font(Font.custom("SportSpiritAf", size: 70))
                            
                                .multilineTextAlignment(.leading)
                                .cornerRadius(10)
                        } .frame(width: 400))
                        {
                            
                            ForEach(games){ game in
//                                VStack{
//                                    Text(game.firstName)
//
//                                    Text(game.lastName)
//
//
//
//                                } .frame(width: 300, height: 150)
//                                    .bold()
//                                    .background(.red)
//                                    .cornerRadius(5)
//
                                VStack{
                                    Cards(game: game)
                                }
                                
                                
                                
                            }
                            
                        }
                    }
                    
                    
                    Spacer()
                    Spacer()
                }
                
            }
                
                
                
            .navigationTitle("Explore")
            
            
        }
        
        
    }
 
}

struct ExplorePage_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePage()
    }
}



private extension ExplorePage{
   
    struct Filter {
        var name : String
        var image : String
    }
 
    
    
    
}
//    struct filterspage23: View {
//        private let filters: [Filters] = [
//            Filters( name: "Baseball"),
//            Filters( name: "Chess"),
//            Filters( name: "Soccer"),
//            Filters( name: "Football"),
//            Filters( name: "Basketball"),
//        ]
//
//
//
//
//        var body: some View {
//            ScrollView(.horizontal){
//                HStack(spacing:20){
//                    ForEach(filters) { filters in
//                        Button{}label: {
//                            Text(filters.name).font(.system(size: 15))
//                        }
//
//
//
//
//                    }.buttonStyle(.plain)
//                        .padding()
//                        .frame(width: .infinity)
//                        .background(Color(.gray)).cornerRadius(90)
//                }
//            }
//        }
//    }
    
    
//    struct Imagecard: View {
//        var body: some View {
//            VStack(alignment: .leading, spacing: 50) {
//                Image("card")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 240, height:200)
//                cardText
//                    .padding(.horizontal, 0)
//                }
//            .background(.white)
//            .clipShape(RoundedRectangle(cornerRadius: 24.0))
//                .shadow(radius: 8.0)
//        }
//
//
//        var cardText: some View {
//            VStack(alignment: .leading, spacing:4.0){
//                Text("Morning Workout").font(.headline)
//                HStack(spacing:4.0){
//                    Image(systemName: "clock.arrow.circlepath")
//                    Text("10 min")
//                }.foregroundColor(.gray)
//            }.padding()
//        }
//    }
//}
