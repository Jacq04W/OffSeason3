//
//  NotificationPage.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI

struct NotificationPage: View {
    var body: some View {
                NavigationStack {
                    ZStack {
                        VStack {
                           
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
            }


        

    
struct NotificationPage_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPage()
    }
}
