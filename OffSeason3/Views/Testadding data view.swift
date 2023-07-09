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
    
    enum ButtonPressed{
        case save, photo
    }
    
    
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
    @State var player : Player

    @State private var annotations: [Annotation] = []
//misc
    @State private var showSearchPage = false
    @Environment (\.dismiss) private var dismiss
    @State private var showingAsSheet = false
    @State private var buttonPressed = ButtonPressed.photo
    @State private var showSaveAlert = false
    @State private var showPhotoViewSheet = false
    @State private var isShowingNext = false
    @State private var isShowingCreateSheet = false

//maps
@State private var mapRegion = MKCoordinateRegion ()
    let regionSize = 500.0
    @State private var showMap = false
    
    // ImagePicker
    @State var image: UIImage?
    @State var newPhoto =  Photo()
    @State private var selectedPhoto: PhotosPickerItem?
    @State var shouldShowImagePicker = false
    @State private var uiImageSelected = UIImage()

    var body: some View {
        VStack{
            
            
            if !isShowingNext {
                
                ScrollView {
                    ZStack {
                        VStack{
                            coverPhoto
                            Spacer()
                            VStack{
                                Section(header:
                                            Text("Customize Your Game").bold()
                                    .font(Font.custom("SportSpiritAf", size: 35))){
                                        TextFields
                                        mapLayer
                                            .onChange(of:game){ _ in
                                                annotations = [Annotation(name: game.name, address: game.address, coordinate: game.coordinate)]
                                                mapRegion.center = game.coordinate
                                            }
                                        
                                    }
                                    .padding()
                                
                            }
                            
                        }
                       

                    }
                }.toolbar{
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Back"){
                            withAnimation{
                                
                                dismiss()
                            }}
                    }
                    ToolbarItemGroup(placement: .automatic) {
//                        nextButton
                        
                                    saveButton
                        
                    }
                }
                
                .onAppear{
                    // otherwise  center the map on the devices location
                    Task {
                        // make map region shows user lo
                        mapRegion = MKCoordinateRegion(center: locationVm.location?.coordinate  ?? CLLocationCoordinate2D(), latitudinalMeters: regionSize, longitudinalMeters: regionSize)
                        
                        
                    }
                    annotations = [Annotation(name: game.name, address: game.address, coordinate: game.coordinate)]
                    
                    print("😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️")
                }
                .onChange(of: selectedPhoto){ newValue in
                    Task{
                        do{
                            if let data = try await newValue?.loadTransferable(type: Data.self){
                                
                                if let uiImage = UIImage(data: data){
                                    
                                    uiImageSelected = uiImage
                                    print("📸Succcesffullly selected image")
                                    newPhoto = Photo() // clears out contents if you add more than 1 photo in a row for this spot
                                    buttonPressed = .photo
                                    
                                    // use this because if there is no spot we need to save the spot first then continue with the action we just pressed
                                    //                                if game.id == nil {
                                    //                                    showSaveAlert.toggle()
                                    //                                } else {
                                    //                                    showPhotoViewSheet.toggle()
                                    //                                }
                                    
                                    showPhotoViewSheet.toggle()
                                    
                                    
                                }
                                
                            }
                        } catch {
                            print("🤬Error Selecting Image failed \(error.localizedDescription)")
                        }
                    }
                    print("👾👾 On change of photos working ")
                    
                }
            } else {
                NavigationStack{
                EditDeleteGame(game: game)
                }
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .bottom)))
                
            }
        }
            .alert("This feature is not yet availbale here... Go to next page to add photos  🤟🏿⚡️",isPresented: $showSaveAlert){
                Button ("Ok", role: .cancel) {}
                
            }

            .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)}
//            .fullScreenCover(isPresented: $isShowingNext, onDismiss: nil) {
//                NavigationStack{
//                    EditDeleteGame(game: game)}
//            }
            .sheet(isPresented: $showSearchPage){
                PlaceLookupView(game: $game)
            }
            .sheet(isPresented: $isShowingCreateSheet){
SignUpPage(player: player)
                
            }

            .sheet(isPresented: $showPhotoViewSheet){
            PhotoView(photo: $newPhoto, game: game, uiImage: uiImageSelected)}
        
        
        
    }
}

struct Testadding_data_view_Previews: PreviewProvider {
    static var previews: some View {
        TestaddingDataView(game:Game(), player: Player())
            .environmentObject(GameViewModel())
            .environmentObject(LocationManager())

    }
}



private extension TestaddingDataView {
    // new code⚡️
    var mapLayer : some View {
        VStack{
            if !game.locationName.isEmpty || !game.address.isEmpty {
                VStack{
                    Text("Correct location ?")
                        .font(Font.custom("SportSpiritAf", size: 40))
                        .lineLimit(1)
                        .bold()
                        .foregroundColor(.black)

            TextField("Location Name",text:$game.locationName).disabled(true)
                        .textFieldStyle (.roundedBorder)
                        .overlay {
                            RoundedRectangle (cornerRadius: 5)
                                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                        }
                    
                    TextField("Address", text: $game.address)
                        .disabled(true)
                        .autocorrectionDisabled()
                        .textFieldStyle (.roundedBorder)
                        .overlay {
                            RoundedRectangle (cornerRadius: 5)
                                .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                        }
                    Map(coordinateRegion: $mapRegion,showsUserLocation: true, annotationItems:annotations){
                        annotation in
                        MapMarker(coordinate: annotation.coordinate)
                    }                       .allowsHitTesting(false)
                        .frame(height: 250)
                        .cornerRadius(10)
                    
                    
                    
                }
//
                
                
            }
        }

//
    }
    
    
    
    // new code⚡️
    var TextFields : some View  {
        VStack{
            TextField("Event name", text: $game.name )
                .textFieldStyle (.roundedBorder)
                .disableAutocorrection(true)

                .overlay {
                    RoundedRectangle (cornerRadius: 5)
                        .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                }
        TextField("Game type",text:$game.summary)
            //TODO: MAKE THIS AN ENUM OF THE THE GAMES YOU CAN PICK
                .textFieldStyle (.roundedBorder)
                .overlay {
                    RoundedRectangle (cornerRadius: 5)
                        .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                }
            HStack {
                DatePicker(selection: $game.startDate, in:  Date()...Date().addingTimeInterval(6 * 30 *  24 * 60 * 60), displayedComponents: .date) {
                    Text("Start Date:")
                }.padding(.leading)
                    .padding(.top,5)
                    .padding(.bottom,5)
                    .padding(.trailing)
                .overlay {
                    RoundedRectangle (cornerRadius: 5)
                        .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                }
//
            }
            TextField("Description", text: $game.description)
                .textFieldStyle (.roundedBorder)
                .overlay {
                    RoundedRectangle (cornerRadius: 5)
                        .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                }
            
            
            Button{
                showSearchPage.toggle()
                showMap.toggle()
                
            }
            label : {
                HStack{
                    Text("Location")
                        .font(Font.custom("SportSpiritAf", size: 35))
                        .foregroundColor(.red)
                   
                    
                    
                    
                }.overlay{
                    HStack(spacing: 1) {
                        Text("Tap")
                            
                        Image(systemName: "lasso")
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .offset(x:130,y:4)

                }
                    
            }
            .frame(width: 360,height:40)
                .textFieldStyle (.roundedBorder)
                .overlay {
                    RoundedRectangle (cornerRadius: 5)
                        .stroke(.gray.opacity(0.5), lineWidth: game.id == nil ? 2 : 0)
                        .onTapGesture {
                            showSearchPage.toggle()

                        }
                }
            
            
            
            
            
        }
    }
    
    

    
    // new code⚡️
    var coverPhoto : some View {
    
//        Image(uiImage: uiImageSelected)
//            .resizable()
//            .scaledToFit()
//        
        Image ("cover2")
            .resizable()
            .scaledToFill()
            .frame(width:350,height: 240)
            .cornerRadius(10)
            .clipped()
            .overlay(
                HStack{
                    Button{
                        showSaveAlert.toggle()
                    }
                    label : {
                        Image(systemName: "photo")
                        Text ("Photo" )
                    }
                    .bold()
                    .padding()
                    .frame(height:40)
                    .foregroundColor(.black)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
                // this photos picker auto makes a button we have to provide the label
//                PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic){
//                    HStack{Image(systemName: "photo")
//                        Text ("Photo" )
//                    }
//                    .padding()
//                    .frame(height:40)
//                    .foregroundColor(.black)
//                    .background(.orange)
//                    .cornerRadius(10)
//                }
//
            
            
            )
        
    }
       
       
    
    
    
    // new code⚡️
    var saveButton : some View
    {
        Button("Confirm"){
//            if player.id == nil {
//                isShowingCreateSheet.toggle()
//                print("🤬Error: NO PLYER ID ")
//
//            } else {
                Task{
                    let success = await
                    gameVm.saveGame(game: game)
                    if success {
                        withAnimation{
                            isShowingNext.toggle()
                            
                        }
                    }
                    else {
                        print("🤬Error: Couldnt save Game")
                    }
                }
            
        }.disabled(game.name == "" && game.category == "" && game.locationName == ""  )
    }
    
    // new code⚡️
    var nextButton : some View {
        Button {
            withAnimation{
                isShowingNext.toggle()
                //                  dismiss()
                
            }
        } label: {
            Text("Next")
        }
        .disabled(game.name == "" && game.category == "" && game.locationName == "")
    }

    // new code⚡️
   
    // new code⚡️
   
    // new code⚡️
    // new code⚡️

    // new code⚡️

    // new code⚡️

    // new code⚡️

    // new code⚡️

    // new code⚡️

    // new code⚡️

    // new code⚡️

    

    
    
    
    
    
    
    
    
    
    
}
