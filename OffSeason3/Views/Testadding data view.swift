//
//  Testadding data view.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 5/29/23.
//

import SwiftUI

struct TestaddingDataView: View {
    @EnvironmentObject var gameVm : GameViewModel
    @State var game : Game
    @State private var showSearchPage = false
    @Environment (\.dismiss) private var dismiss
    var body: some View {
        NavigationStack{
            ScrollView {
                ZStack {
                    VStack{
                        coverPhoto
                        Spacer()
                        VStack{
                    Section(header: Text("Customize Your Game")
                                        .bold()
                                        .font(.title)){
                                       TextFields
                                                .padding()
                                            
                                            Button{
                                                showSearchPage.toggle()
                                            } label: {
                                                Image(systemName: "magnifyingglass")
                                            }
                                        
                                            
                                            
                                        }
                        }
                       
                    }
                }
            }
        }
        .sheet(isPresented: $showSearchPage, content: {
            PlaceLookupView( game: $game)
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
    }
}



private extension TestaddingDataView {
    
    
    
    
    
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
