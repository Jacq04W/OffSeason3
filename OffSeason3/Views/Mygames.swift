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
    @State var choice = 3
    @FirestoreQuery(collectionPath: "games") var games : [Game]
    var body: some View {
        NavigationView {
            List(games) { game in
                
    if game.posterEmail == Auth.auth().currentUser?.email {
        
                    
                } else {
                    
                }
                
                
            }
//            ZStack {
//                VStack {
//                    Picker("Color Scheme", selection: $choice){
//                        Text("Upcoming").tag(1)
//                        Text("Shit").tag(2)
//                        Text("Past").tag(3)
//                    }.pickerStyle(SegmentedPickerStyle())
//                        .padding()
//                Spacer()
//
//
//                    List {
//                        HStack {
//                            //User-inputted image of the dog spotted
//                                Image("card")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(maxHeight: 200.0)
//                            Button {
//                            } label: {
//                                //Information about the dog spotted
//                                VStack(alignment: .leading) {
//                                    //Dog's name
//
//                                    Text("Super run")
//                                        .font(.title)
//                                    Text("LA fitness")
//                                        .font(.title2)
//
//                                    //Time when dog was seen
//                                    Text("Created on \(Date().formatted())")
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                    }
////                    .sheet(isPresented: $isShowingNewSpotSheet, content: {
////                        NewSpotView(dogVM: dogVM)
////                    })
//
////                        Section{
////
////                            Text("Upcoming games")
////
////                        }
////
////                        .padding()
//
//                    }.headerProminence(.increased)
//                        .listStyle(.insetGrouped)
//
//
//
//
//
//
//
//
//                        .navigationTitle("My Games")
//                }
            }
        }
    }


struct Mygames_Previews: PreviewProvider {
    static var previews: some View {
        Mygames()
    }
}
