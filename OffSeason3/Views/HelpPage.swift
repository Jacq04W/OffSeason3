//
//  HelpPage.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI

struct HelpPage: View {
    let items = 1...6

    let rows = [
            GridItem(.fixed(50)),
            GridItem(.fixed(50))
        ]

    
    struct BlueButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
    struct RedButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(Color(red: 0.9, green: 0, blue: 0))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
    var body: some View {
        VStack(spacing:120){
            Text("Get Help").font(.largeTitle)
            HStack(spacing: 120 ){
               
                
                VStack{
                    Text("Emergency categories")
                    
                    
                    
                        
                        
                        
                        ScrollView(.horizontal) {
                                   LazyHGrid(rows: rows, alignment: .center) {
                                       ForEach(items, id: \.self) { item in
                                           Image(systemName: "\(item).circle.fill")
                                               .font(.largeTitle)
                                       }
                                   }
                                   .frame(height: 150)
                               }
                        
                        
                        
                        
                        
                        
                        //                    Text("Don't try to move a person who is unconscious after having an accident. He or she may have a neck or other spine injury. Call 911 or get help. If the person is not breathing and you know CPR, have someone else get help while you take care of the injured person.").padding()
                        
                    
                }.padding()
                
            }
            Text("Get Help")
            HStack{
                Button{}label: {
                    Text("Call 911")
                }.buttonStyle(RedButton())
                
//                Button{}label: {
//                    Text("Nearest Hostpital")
//                }
//
                
                Button{}label: {
                    Text("Nearest Hostpital")
                }.buttonStyle(BlueButton())
                
                
            }
            
        }
    }
}

struct Helpage_Previews: PreviewProvider {
    static var previews: some View {
        HelpPage()
    }
}
