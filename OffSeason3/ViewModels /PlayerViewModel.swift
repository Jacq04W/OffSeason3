//
//  PlayerViewModel.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 6/4/23.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage


class PlayerViewModel: ObservableObject{
    @Published var game = Game()
    @Published var player = Player()
    @Published var selectedGame: Game? = nil

    func addPlayer(game:Game,player:Player) async -> Bool{
        let db = Firestore.firestore()
        guard let gameID = game.id else {
            print("Error: Game ID == Nil")
            return false
        }
        let collectionString = "games/\(game.id)/players"
        
        
        if let id = player.id { // update the data that alrsady here
        do {
            try await db.collection(collectionString).document(id).setData (player.dictionary)
        print ("😎 Player Joined successfully!")
        return true
        } catch {
            print ("🤬ERROR: Could not update data in'players'\(error.localizedDescription)")
           return false
        }
        } else {
            // no id so we are adding a new player
            // add data to firestore
            do{
                
        let documentRef = try await db.collection(collectionString).addDocument(data: player.dictionary)
//            // this is to make sure we are updating the the 'spot' on xcode when a new value is inputed, so thay we have a id before its in fb
//                self.player  = player
//                self.player.id = documentRef.documentID
                print("😎 Data added succesfully ")
                return true
            } catch{
                print("🤬Error: could not add data \(error.localizedDescription)")
                return false
                
            }
        }
    }
    

        
    
}
