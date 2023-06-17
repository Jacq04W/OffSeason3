//
//  SignUpPage.swift
//  OffSeason3
//
//  Created by Rheyya Hollins on 6/5/23.
//

import SwiftUI

struct SignUpPage: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var birthDate = Date.now
    @State private var isShowingCreateSheet = false
    @EnvironmentObject var playerVM : PlayerViewModel
    @Environment(\.dismiss) var dismiss
    @AppStorage("firstLogin") var firstLogin = true

    @State var player : Player
    var body: some View {
        NavigationView{
            ZStack{
                Color.orange
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                VStack{
                    VStack(spacing: -20){
                        Text("Finish Creating")
                            .lineLimit(1)
                            .font(Font.custom("SportSpiritAf", size: 40))
                            .bold()
                            .padding()
                        Text("Profile")
                            .lineLimit(1)
                            .font(Font.custom("SportSpiritAf", size: 40))
                            .bold()
                            .padding()
                    }
                    HStack{
                        TextField ("First Name", text: $player.firstName)
                            .autocorrectionDisabled()

                            .padding ()
                            .frame (width: 150, height: 50)
                            .background (Color.black.opacity (0.05))
                            .cornerRadius (10)
                        TextField ("Last Name", text: $player.lastName)
                            .autocorrectionDisabled()

                            .padding ()
                            .frame (width: 150, height: 50)
                            .background (Color.black.opacity (0.05))
                            .cornerRadius (10)
                    }
                    
                    TextField("Username", text: $player.userName)
                        .autocorrectionDisabled()
                        .padding ()
                        .frame (width: 300, height: 50)
                        .background (Color.black.opacity (0.05))
                        .cornerRadius (10)
                        .border(.red, width: CGFloat(wrongUsername))
                    HStack {
                        DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                            Text("Date Of Birth:")
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding(.horizontal)
                    }
                    
                    Button ("Submit") {
//                        authenticateUser(username: username, email: email, password: password)
                        Task{
                            let success = await playerVM.savePlayer(player: player)
                if success {
                    withAnimation{
                        isShowingCreateSheet.toggle()
                        
                    }
                            } else {
                                print("Error: 🤬Could not create a player gang")
                            }
                        }
                        
                        
                        
                        
                    }
                    .disabled(player.firstName == "" && player.lastName == "" )
                    .font(Font.custom("SportSpiritAf", size: 30))
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    //TODO: NAVIGATION STACK 
                
                }
            }.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back"){
                    }.disabled(player.firstName == "" && player.lastName == "" )
                }
            }
            .sheet(isPresented: $isShowingCreateSheet) {
                NavigationStack{
                    TestaddingDataView(game: Game(),player: player)
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    
    func authenticateUser(username: String, email: String, password: String){
        if username.lowercased() == "rheyya2022"{
            wrongUsername = 0
            if email.lowercased() == "rheyya@gmail.com"{
                wrongEmail = 0
                if password.lowercased() == "abc123"{
                    wrongPassword = 0
                    showingLoginScreen = true
                } else{
                    wrongPassword = 2
                }
            } else{
                wrongEmail = 2
            }
        } else{
            wrongUsername = 2
        }
    }
    
    struct SwiftUIView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpPage(player:Player())
                .environmentObject(PlayerViewModel())
        }
    }
}
