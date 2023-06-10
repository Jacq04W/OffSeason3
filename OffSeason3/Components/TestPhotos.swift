//
//  TestPhotos.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 6/8/23.
//

import SwiftUI
import MapKit
import FirebaseFirestoreSwift
import PhotosUI

enum ButtonPressed{
    case save, photo
}



struct TestPhotos: View {
    @State private var selectedPhoto : PhotosPickerItem?
    @State private var uiImageSelected = UIImage()
    @FirestoreQuery(collectionPath:"games") var photos: [Photo]
    @State var newPhoto =  Photo()
    @State private var showPhotoSheet = false
   @State var uiImage: UIImage
    @Environment(\.dismiss) private var dismiss
    @State var game: Game
    @State var player: Player
    @State private var buttonPressed = ButtonPressed.save

    @EnvironmentObject private var gameVm: GameViewModel
    @Binding var photo : Photo

    var body: some View {
        NavigationStack {
            VStack {
                VStack{
                    PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic){
                        Image(systemName: "photo")
                        Text ("Photo" )
                    }
                    .onChange(of: selectedPhoto){ newValue in
                        Task{
                            do{
                                if let data = try await newValue?.loadTransferable(type: Data.self){
                                    if let uiImage = UIImage(data: data){
                                        uiImageSelected = uiImage
                                        print("📸Succcesffullly selected image")
                                        newPhoto = Photo()
                                    }
                                }
                            } catch {
                                print("🤬Error Selecting Image failed \(error.localizedDescription)")
                            }
                        }
                    }
                    TextField("name", text: $game.name)
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }.onAppear{
                if game.id != nil {
                    $photos.path = "games/\(game.id ?? "")/photos"
                    
                    print("photos.path = \($photos.path)")}
                
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                Button("Save"){
                    Task{
                        let success =  await gameVm.saveGame(game: game)
//                        let success2 =  await gameVm.saveImage(game: game, photo: photo, image: uiImage)
                        if success {
//                            $photos.path = "games/\(game.id ?? "")/photos"
                            dismiss()
                        } else {
                            print("🤬Dang Error saving game and images ")
                        }
                    }
                    
                    
                }
            }
            } .sheet(isPresented: $showPhotoSheet) {
                NavigationStack{
                    PhotoView(photo:$newPhoto,game:game, uiImage:uiImageSelected)
                }
                
            }
        }

    }


struct TestPhotos_Previews: PreviewProvider {
    static var previews: some View {
        TestPhotos(uiImage: UIImage(named: "temp1") ?? UIImage(), game: Game(), player: Player(), photo: .constant(Photo()))
            .environmentObject(GameViewModel())
        }
    }
}
