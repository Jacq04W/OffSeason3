//
//  ContentView.swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 5/29/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
//if i want to create my own google button i would delte these and the actual button below and create it myself
import GoogleSignIn
import GoogleSignInSwift


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var presentSheet = false
    @State private var showOnboard = false
    @State private var showSignInView: Bool = false
    @State private var buttonsDisabled = false
    @FocusState private var focusFiel : Field?
    
    var player: Player
    @EnvironmentObject var googleVm : AuthenticationViewModel
    enum Field{
        case email,password
    }
    @FocusState private var focusField: Field?
    var body: some View {
        VStack {
            NavigationStack {
                VStack{
                    ZStack{
                        Image("logo1")
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                    }
                    Group{
                        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                            Task {
                                do {
                                    try await googleVm.signInGoogle()
                                    presentSheet = true
                                } catch {
                                    print(error)
                                }
                            }
                        }
                        
                        TextField("Email", text:$email)
                            .keyboardType (.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .submitLabel(.next)
                            .focused($focusField, equals: .email)
                            .onSubmit{
                              focusField = .password
                            }
                            .onChange(of: email){ _ in
                                enablebuttons()
                            }
                    
                        SecureField("password", text: $password)
                            .textInputAutocapitalization(.never)
                            .submitLabel(.done)
                            .focused($focusField, equals: .password)
                            .onSubmit{
                                focusField = nil
                                
                            }
                            .onChange(of: password){ _ in
                                enablebuttons()
                            }
                        
                    }
                    .textFieldStyle(.roundedBorder)
                    .overlay{
                        RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray.opacity(0.5),lineWidth:2)
                    }
                    .padding(.horizontal)
                    HStack{
                        Button{
                            register()
                        } label : {
                            Text("Sign Up")
                            
                        }  .tint(Color.red)
                        .padding(.trailing)
                        Button{
                            login()
                            
                        } label : {
                            Text("Log in")
                                
                        }.tint(Color.red)
                        .padding(.leading)
                    }//Hstsack
                    .disabled(buttonsDisabled)
                    .buttonStyle(.borderedProminent)
                  
                    .font(.title2)
                    .padding(.top)
                    .navigationBarTitleDisplayMode(.inline)
                    // how to properly naviaget to a new view
            .navigationDestination(for: String.self){ view in
                        if view == "MapView"{
                            MapView()
                        }
                    }
                }// nav stack
                .alert(alertMessage, isPresented: $showingAlert){
                    Button("OK",role:.cancel){
                         
                    }
                }// alert

                .onAppear{
                    // if logged in when the app runs, navigate to the new screen
                    if Auth.auth().currentUser != nil {
                        print ("🪵 Login successful !")
                        presentSheet = true
                     
                    }
//                    else {
//                        showOnboard.toggle()
//                    }
                }
                .fullScreenCover(isPresented: $presentSheet){
                  ContentView()
            }
                .fullScreenCover(isPresented: $showOnboard){
                  OnBoarding()
//
            }
            }
        }
        
    }
    
    
    
    // fucntion
    
    
    func enablebuttons(){
        let emailIsGood = email.count >= 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        buttonsDisabled = !(emailIsGood && passwordIsGood)
    }
    
    func register(){
        Auth.auth().createUser(withEmail:email,password:password){
            result,error in
            if let error = error {
                print("🤬 Error: SIGN-UP Error:\(error.localizedDescription)")
                alertMessage = "SIGN-UP Error:\(error.localizedDescription)"
                showingAlert = true
                // mayhbe
            }
            else{
                print ("😎 Registration success!")
                /// load list view
                         presentSheet = true

            }
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail:email,password:password){
            result,error in
            if let error = error {
                print("🤬 Error: Login Error:\(error.localizedDescription)")
                alertMessage = "Login Error:\(error.localizedDescription)"
                showingAlert = true
            }
            else{
                print ("🪵 Login successful !")
                presentSheet = true
                /// load list view
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(player:Player())
            .environmentObject(AuthenticationViewModel())
    }
}
