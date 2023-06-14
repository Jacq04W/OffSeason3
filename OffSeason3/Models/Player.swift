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
    var firstName = ""
    var lastName = ""
    var userName = ""
    var email = Auth.auth().currentUser?.email ?? ""
    var age = Date()
    var gender = ""
    
    
    
    
    var dictionary:[String:Any]{
        return [
            "firstName" : firstName,
            "lastName" : lastName,
            "userName" : userName,
            "email" : email,
            "age" : Timestamp(date: age),
            "gender" : gender,
        ]
    }

}
