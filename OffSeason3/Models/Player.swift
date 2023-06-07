//
//  Player.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 6/1/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

struct Player : Identifiable{
    @DocumentID var id : String?
    var name = ""
    var userName = ""
    var email = Auth.auth().currentUser?.email ?? ""
    var age = ""
    var gender = ""
    
    
    
    
    var dictionary:[String:Any]{
        return [
            "name" : name,
            "userName" : userName,
            "email" : email,
            "age" : age,
            "gender" : gender,
        ]
    }

}
