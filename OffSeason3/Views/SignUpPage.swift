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
                    Text("Sign Up")
                        .font(Font.custom("SportSpiritAf", size: 40))
                        .bold()
                        .padding()
                    HStack{
                        TextField ("First Name", text: $username)
                            .padding ()
                            .frame (width: 150, height: 50)
                            .background (Color.black.opacity (0.05))
                            .cornerRadius (10)
                        TextField ("Last Name", text: $username)
                            .padding ()
                            .frame (width: 150, height: 50)
                            .background (Color.black.opacity (0.05))
                            .cornerRadius (10)
                    }
                    
                    TextField ("Username", text: $username)
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
                        
                    TextField ("Email", text: $email)
                        .padding ()
                        .frame (width: 300, height: 50)
                        .background (Color.black.opacity (0.05))
                        .cornerRadius (10)
                        .border(.red, width: CGFloat(wrongEmail))
                    
                    SecureField ("Password", text: $password)
                        .padding ()
                        .frame (width: 300, height: 50)
                        .background (Color.black.opacity (0.05))
                        .cornerRadius (10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button ("Login") {
                        authenticateUser(username: username, email: email, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.orange)
                    .cornerRadius(10)
                    //TODO: NAVIGATION STACK 
                    NavigationLink(destination: Text("You are logged in @\(username)"), isActive: $showingLoginScreen){
                        EmptyView()
                    }
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
            SignUpPage()
        }
    }
}
