//
//  NotificationPage.swift
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

struct NotificationPage: View {
    var body: some View {
                NavigationStack {
                    ZStack {
                        VStack {
                            Button("signout"){
                                signOut()
                                print("signed Out")
                            }
                        Spacer()
                           
                                List {
                                    HStack {
                                       
                                        Button {
                                        } label: {
                                        
                                        VStack(alignment: .leading) {
                                            //Game name
                                           
                                            Text("Super run")
                                                .font(.title)
                                            Text("LA fitness")
                                                .font(.title2)
                                            
                                            //Time when game  was created
                                            Text("Created on \(Date().formatted())")
                                                .foregroundColor(.secondary)
                                        }.padding()
                                    }
                                }
                            }

                            
                           
        //                    .sheet(isPresented: $isShowingNewSpotSheet, content: {
        //                        NewSpotView(dogVM: dogVM)
        //                    })
                           
        //                        Section{
        //
        //                            Text("Upcoming games")
        //
        //                        }
        //
        //                        .padding()
                                
                            }.headerProminence(.increased)
                                .listStyle(.insetGrouped)
                              
                            
                            
                        
                        
                        
                        
                        
                        
                               
                        }.navigationTitle("Notifications")
                      
                    }
                }
    
    
    func signOut() {
         do {
             try Auth.auth().signOut()
             // Handle successful sign-out
             // For example, navigate to a login screen
         } catch let signOutError as NSError {
             // Handle sign-out error
             print("Error signing out: \(signOutError.localizedDescription)")
         }
     }
            }


        

    
struct NotificationPage_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPage()
    }
}
