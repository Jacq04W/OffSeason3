//
//  Testadding data view.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 5/29/23.
//

import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

struct TestaddingDataView: View {
    
    struct Annotation : Identifiable{
        let id = UUID().uuidString
        var name : String
        var address : String
        var coordinate : CLLocationCoordinate2D
    }
// ViewModela
    @EnvironmentObject var gameVm : GameViewModel
    @EnvironmentObject var locationVm : LocationManager
//data
    @State var game : Game
    @State private var annotations: [Annotation] = []
//misc
    @State private var showSearchPage = false
    @Environment (\.dismiss) private var dismiss
    @State private var showingAsSheet = false
//maps
@State private var mapRegion = MKCoordinateRegion ()
    let regionSize = 500.0
    @State private var showMap = false

    var body: some View {
        NavigationStack{
            ScrollView {
                ZStack {
                    VStack{
                        coverPhoto
                        Spacer()
                        VStack{
                    Section(header:
                    Text("Customize Your Game")
                        .bold()
                        .font(.title)){
                            TextFields
                                .padding()
                                        }
                            mapLayer
                                .onChange(of:game){ _ in
                                    annotations = [Annotation(name: game.name, address: game.address, coordinate: game.coordinate)]
                                    mapRegion.center = game.coordinate
                                }
                                
    
                        }
                       
                    }
                }
            }
        }
        .onAppear {
            if game.id != nil { // If we have a spot, center map on the spot
                mapRegion = MKCoordinateRegion (center: game.coordinate,
                                                latitudinalMeters: regionSize,
                                                longitudinalMeters: regionSize)
            } else {
                Task{
    mapRegion = MKCoordinateRegion(center:
locationVm.location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: regionSize,
    longitudinalMeters: regionSize)
                }
                }
            annotations = [Annotation (name: game.name, address: game.address,
            coordinate: game.coordinate)]
            
        }
        .sheet(isPresented: $showSearchPage, content: {
            PlaceLookupView(game: $game)
        })
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Save"){
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
            }
            
            
        }
        
    }
}

struct Testadding_data_view_Previews: PreviewProvider {
    static var previews: some View {
        TestaddingDataView(game:Game())
            .environmentObject(GameViewModel())
            .environmentObject(LocationManager())

    }
}



private extension TestaddingDataView {
    
    var mapLayer : some View {
        Map(coordinateRegion: $mapRegion,showsUserLocation: true, annotationItems:annotations){
            annotation in
            MapMarker(coordinate: annotation.coordinate)
        }.frame(height: 250)
            .cornerRadius(20)
    }

    
    var TextFields : some View  {
        VStack{
TextField("Event name", text: $game.name )
                .textFieldStyle (.roundedBorder)
                .overlay {
                RoundedRectangle (cornerRadius: 5)
                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
            }
TextField("Summary",text:$game.summary)
                .textFieldStyle (.roundedBorder)
                .overlay {
                RoundedRectangle (cornerRadius: 5)
                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
            }
TextField("Description", text: $game.description)
.textFieldStyle (.roundedBorder)
.overlay {
RoundedRectangle (cornerRadius: 5)
.stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
}
            
            
            Button("Location"){
showSearchPage.toggle()
    showMap.toggle()

                }.frame(width: 360,height:40)
                .textFieldStyle (.roundedBorder)
                    .overlay {
                    RoundedRectangle (cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                }

            
            
            if !game.locationName.isEmpty && !game.address.isEmpty {
                TextField("Location Name",text:$game.locationName).disabled(true)
                    .textFieldStyle (.roundedBorder)
                    .overlay {
                        RoundedRectangle (cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                    }
                
                
                
                
                Text("Confirm your location is correct")
                          .bold()
                          .font(.title2)
                Map(coordinateRegion: $mapRegion,showsUserLocation: true, annotationItems:annotations){
                    annotation in
                    MapMarker(coordinate: annotation.coordinate)
                }.frame(height: 250)
                
            }
         
            
TextField("Address", text: $game.address)
.autocorrectionDisabled()
                            .textFieldStyle (.roundedBorder)
                        .overlay {
                                                RoundedRectangle (cornerRadius: 5)
                                                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                                            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    var coverPhoto : some View {
        Image ("temp1")
            .resizable()
            .scaledToFill()
            .frame(width:350,height: 240)
            .cornerRadius(10)
            .clipped()
            .overlay(
                HStack{
                    Button{}
                label:{
                    Image(systemName: "photo")
                    Text("Cover Photos")
                }
                }
                    .foregroundColor(.black)
                    .padding()
                    .background(.orange)
                    .cornerRadius(20))
           
    }
}
