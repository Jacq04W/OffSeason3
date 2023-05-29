////
////  AddStore.swift
////  TheMove
////
////  Created by Jacquese Whitson  on 4/15/23.
////
//
//
//import CoreLocation
//import FirebaseCore
//import FirebaseFirestoreSwift
//import FirebaseDatabase
//import MapKit
//import SwiftUI
//
//struct Annotation {
//    var id : String?
//    var name = ""
//}
//
//struct AddEvent: View {
//    @State private var annotations: [Annotation] = []
//    @State private var showMap = false
//    @State private var showPlaceLookupSheet = false
//    @State var isPickerShowing = false
//    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    let regionSize = 500.0
//
//    @EnvironmentObject private var gameVm: GameViewModel
//    @State var game: Game
//
//    var previewRunning = false
//    @Environment(\.dismiss) private var dismiss
//    
//    
//    @FirestoreQuery(collectionPath: "games") var games : [Game]
////    42.33157
////    -83.045839
//    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.331578, longitude: -83.045839), span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//    
////    @EnvironmentObject private var locationVm : LocationManager
//   
////    (locationVm.location?.coordinate.latitude ?? 0.00),\(locationVm.location?.coordinate.longitude ?? 0.00)")
//
//    var body: some View {   
//    NavigationStack{
//        ScrollView {
//            ZStack {
//                VStack{
//                    coverPhoto
//                   Spacer()
//                    VStack{
//                    Section(header: Text("Customize Your Game ")
//                                .bold()
//                        .font(.title)) {
//                        VStack{
//                            TextField("Username", text: $game.name)
//                            TextField("Event Name",text:$game.address)                             .autocorrectionDisabled()
//                                                            .textFieldStyle (.roundedBorder)
//                                                                .overlay {
//                                                                RoundedRectangle (cornerRadius: 5)
//                                                                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
//                                                            }
////                                                        TextField("Summary",text:$game.summary)
////                                                            .textFieldStyle (.roundedBorder)
////                                                                .overlay {
////                                                                RoundedRectangle (cornerRadius: 5)
////                                                                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
////                                                            }
////                                                        TextField("Description",text:$game.description)
////                                                            .textFieldStyle (.roundedBorder)
////                                                                .overlay {
////                                                                RoundedRectangle (cornerRadius: 5)
////                                                                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
////                                                            }
//                                                    Button("Location"){
//                                        showPlaceLookupSheet.toggle()
//                                            showMap.toggle()
//
//                                                        }.frame(width: 360,height:40)
//                                                        .textFieldStyle (.roundedBorder)
//                                                            .overlay {
//                                                            RoundedRectangle (cornerRadius: 5)
//                                                            .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
//                                                        }
//                                                        // if the text field is no longer empty
//                                                       
//                                                        if !game.locationName.isEmpty && !game.address.isEmpty {
//                                                        TextField("Location Name",text:$game.locationName).disabled(true)
//                                                            .textFieldStyle (.roundedBorder)
//                                                                .overlay {
//                                                                RoundedRectangle (cornerRadius: 5)
//                                                                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
//                                                            }
//                                                        
//                                                        TextField("Address",text:$game.address).disabled(true)
//                                                            .textFieldStyle (.roundedBorder)
//                                                                .overlay {
//                                                                RoundedRectangle (cornerRadius: 5)
//                                                                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
//                                                            }
//                                                        
//                                                        
//                                                        
//                                                      Text("Confirm your location is correct")
//                                                                .bold()
//                                                                .font(.title2)
//                                                            Map(coordinateRegion: $mapRegion,showsUserLocation: true, annotationItems:annotations){
//                                                                annotation in
//                                                                MapMarker(coordinate: annotation.coordinate)
//                                                            }
//                                                            .cornerRadius(20).frame(height: 250)
//                                                            
//                                                                .onChange(of:game){ _ in
//                                                                    annotations = [Annotation(name: game.name, address: game.address, coordinate: game.coordinate)]
//                                                                    mapRegion.center = game.coordinate
//                                                                }
//                                                        }
//                                                        Button("Ticket Details"){
//                                                            //TODO: ADD ANOTHER PAGE TO ADD HERE
//                                                        }
//                                                    }
//                                                    
//                                            }
//                                    .padding(.horizontal)
//                                  Spacer()
//                                        }
//                    
//                }
//            }
//            
////            .onAppear{
////                if !previewRunning{
////                    $games.path = "players/\(gameVm.player.id ?? "")/events"
////                    print("players.path = \($players.path)")
////                }
////
////            if event.id != nil {// if we have a location center it on the map
////                    mapRegion = MKCoordinateRegion(center: event.coordinate, span: mapSpan)
////                } else {
////                    Task{
////                        mapRegion = MKCoordinateRegion(center: locationVm.location?.coordinate  ?? CLLocationCoordinate2D(), latitudinalMeters: regionSize, longitudinalMeters: regionSize)
////                    }
////                }
////                annotations = [Annotation(name: event.name, address: event.address, coordinate: event.coordinate)]
////
////
////            }
//        //
//                    .toolbar{
//                        ToolbarItem(placement: .automatic) {
//                            saveButton
//                           
//                        }
//                        
//                        ToolbarItem(placement: .cancellationAction) {
//                            Button("Back"){
//                                dismiss()
//                            }
//                        }
//                    }
////                    .sheet(isPresented: $showPlaceLookupSheet) {
////                        PlaceLookupView(event: $event)
////                }
//        }
//        
//            
//        }
//        
//        
//    }
//}
//
//struct AddEvent_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEvent(game: Game(), previewRunning: true)
//        .environmentObject(GameViewModel())
////        .environmentObject(LocationManager())
//
//        
//    }
//}
//
//
//
//
//
//private extension AddEvent {
//    var saveButton: some View{
//        Button("Save"){
//            Task{
//                let success = await gameVm.saveGame(game: game)
//                if success {
//                    dismiss()
//                } else {
//                    print("🤬 Error: Saving spot")
//                }
//            }
//            
//        }
//    }
//        // new code
//    var coverPhoto : some View {
//        Image ("wtm")
//            .resizable()
//            .scaledToFill()
//            .frame(width:350,height: 240)
//            .cornerRadius(10) 
//            .clipped()
//            .overlay(
//                HStack{
//                    Button{}
//                label:{
//                    Image(systemName: "photo")
//                    Text("Cover Photos")
//                }
//                }
//                    .foregroundColor(.black)
//                    .padding()
//                    .background(.orange)
//                    .cornerRadius(20))
//    }
//    
//    // new code
//
//    
//    
//}
