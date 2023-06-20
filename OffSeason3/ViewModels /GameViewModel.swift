//
//  File.swift
// OffSeason3
//
//  Created by Jacquese Whitson  on 4/25/23.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage

// this is beacuse we ere going to be updating the ui from this page  so we need to make sure its in the main thread
@MainActor
class GameViewModel: ObservableObject {
    @Published var game = Game()
    @Published var selectedGame: Game? = nil
    @Published var isJoiningGame = false

    @Published var isDismissing = false

    
    
    
    func saveGame(game:Game) async -> Bool{
        let db = Firestore.firestore()
        if let id = game.id { // update the data that alrsady here
        do {
            try await db.collection("games").document(id).setData (game.dictionary)
        print ("😎 Data updated successfully!")
        return true
        } catch {
        print ("🤬ERROR: Could not update data in'spots'")
           return false
        }
        } else {
            // add data to firestore
            do{
                
        let documentRef = try await db.collection("games").addDocument(data: game.dictionary)
            // this is to make sure we are updating the the 'spot' on xcode when a new value is inputed, so thay we have a id before its in fb
                self.game = game
                self.game.id = documentRef.documentID
                print("😎 Data added succesfully ")
                return true
            } catch{
                print("🤬Error: could not add data")
                return false
                
            }
        }
    }
    
    
    
    func joinEvent(player:Player, game: Game) async -> Bool {
          let db = Firestore.firestore()
          
          // Ensure we have a player ID
        guard let playerID = player.id else {
            print("🤬 ERROR: Could not get player ID.")
            return false
        }
          // Ensure we have an event ID
          guard let gameID = game.id else {
              print("🤬 ERROR: Could not get game ID.")
              return false
          }
          
          // Define the path to the player's events collection
          let collectionString = "games/\(gameID)"
          
          do {
              
                 
              // Check if the player is already joined to the event
              let document = try await db.collection(collectionString).document(gameID).getDocument()
              
              if document.exists {
                  print("😎 Player is already joined to the event.")
                  return true
              } else {
                  // Add the player to the event
              try await db.collection(collectionString).document(gameID).setData(["joined": true], merge: true)
                  print("😎 Player joined the event successfully!")
                  return true
              }
          } catch {
              print("🤬 ERROR: Could not join event. \(error.localizedDescription)")
              return false
          }
      }
    
    
    
    
func saveImage(game: Game,photo: Photo,image: UIImage) async -> Bool {
        guard let gameId = game.id else {
            print("🤬 ERROR: game ID == nil")
            return false
        }
        
        var  photoName = UUID().uuidString
            if photo.id != nil  {// if i have a photo id use the name of the photo id instead of creating a new one, we'll use this so we can update the description of a photo without resaving the photo
                photoName = photo.id!
                }
        let storage = Storage.storage()
        let storageRef = storage.reference().child("\(gameId)/\(photoName).jpeg")
        
        // compressing image
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("🤬 ERROR: could not resize image")
            return false
        }
        
        let metadata = StorageMetadata()
        // Allowds us to dispaly the image in the storgae database
        metadata.contentType = "image/jpg"
        
    // this will hold the url of the image that we saved
        var imageURLString = ""
        
        do {
            // adding the image data to storage (resized, metadata)
    let _ = try await storageRef.putDataAsync(resizedImage,metadata: metadata)
            print("😎 image saved")
            do {
    // gettin the pictures url from storage
    let imageURL = try await storageRef.downloadURL()
//turning URL into a string so i can use it to access/ create new path for spot
                imageURLString = "\(imageURL)"
            }catch{
                print("🤬 ERROR: could not get imageUrl after saving image")
                return false
            }
        }
        catch {
            print("🤬 ERROR: Uploading image to firebase")
            return false
        }
        
        
        
        // Saving Photos to database,
        let db = Firestore.firestore()
        //Creating paths for photos to go
        let collectionString  = "games/\(gameId)/photos"
        do {//
            var newPhoto = photo
            //allows us to display the image
            newPhoto.imageURLString = imageURLString
            
    // updating the database with the meta data of the photo
    // instead of using the .addDocument func use the .document() and plug in the document we already have
    // this way you are updating the document that already exists instead of creating  a new one
try await
            
            db.collection(collectionString).document(photoName).setData(newPhoto.dictionary)
            print("😎 Data updated successfully")
            return true
        }catch{
            print("🤬 ERROR: Could not updte dat in 'photos for spot id")
            return false
        }
        
    } // end func
        
    
    //TODO: test this make sure it deletes the correct thing 
    func deleteReview(game: Game) async -> Bool {
        let db = Firestore.firestore()
        
        guard let gameID = game.id else {
            print("🤬Error: Could not find spot ID")
            return false
        }
        do {

let _ = try await db.collection("games").document(gameID).collection("games").document(gameID).delete()
            print("🗑️ Document Successfully deleted")
            return true


        } catch {
            print("🤬Error: removing document \(error.localizedDescription)")
            return false

            
        }
        
    }
    
    
    
    
    
}// class
