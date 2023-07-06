//  ProfilePage.swift
//  Offseason2
//  ContentView.swift
//  ybi
//
//  Created by Sean Carter on 5/17/23.
//  Created by Ravyn Dobine on 5/17/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

struct ProfilePage: View {
    @State var player: Player
    @State private var showAlert = false
    @State private var showLogin = false
    @Binding var showSignInView : Bool
    @EnvironmentObject var googleVm : AuthenticationViewModel
    var body: some View {
        NavigationStack{
            VStack{
                 
                    ScrollView{
                        HStack{
                            Image(systemName:"person.circle.fill")
                                .resizable()
                                .frame(width:100, height:100)
                                .offset(x:40, y:-10)
                            
                                .padding(.top, -0)
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size:35))
                                .foregroundColor(.orange)
                                .offset(x:40, y:-20)
                            Button("sign out"){
                                Task {
                                    do {
                            try signOut()
                                    showSignInView = true
                                    } catch {
                                        print("Error: Can not sign out")
                                    }
                                }                        }
                            .font(.system(size:20))
                            .foregroundColor(.red)
                            .offset(x:125, y:-35)
                            .fontWeight(.bold)
                            
                            
                        }
                        .frame(maxWidth:.infinity, maxHeight:.infinity,
                               alignment:.leading)
                        
                        VStack{
                            Text("\(player.firstName)")
                                .font(.title2)
                            //                            .font(.system(size: 20))
                            
                                .fontWeight(.bold)
                                .fontDesign(.monospaced)
                                .offset(x:145, y:-50)
                            Button("edit"){
                                showAlert.toggle()
                                
                            }
                            .font(.subheadline)
                            .foregroundColor(.indigo)
                            .fontWeight(.thin)
                            .fontDesign(.monospaced)
                            .padding(-40)
                            .offset(x:75, y:-25)
                            
                            Text(Auth.auth().currentUser?.email ?? "")
                                .font(.body)
                                .fontDesign(.monospaced)
                                .fontWeight(.semibold)
                                .offset(x:70,y:2)
                            Button("edit"){
                                showAlert.toggle()
                                
                            }
                            .font(.subheadline)
                            .fontWeight(.thin)
                            .offset(x:70,y:4)
                            Text("********")
                                .font(.body)
                                .fontDesign(.monospaced)
                                .fontWeight(.semibold)
                                .offset(x:70,y:20)
                            Button("edit"){
                                showAlert.toggle()
                            }
                            .font(.subheadline)
                            .fontWeight(.thin)
                            .offset(x:70,y:20)
                            Text("(313) 333 3133")
                                .font(.body)
                                .fontDesign(.monospaced)
                                .fontWeight(.semibold)
                                .offset(x:70,y:40)
                            Button("edit"){
                                showAlert.toggle()
                            }
                            .font(.subheadline)
                            .fontWeight(.thin)
                            .offset(x:70,y:40)
                            
                            
                            
                        }
                        
                        .frame(maxWidth:.infinity, maxHeight:.infinity,
                               alignment:.leading)
                        
                    }
                    
                
                
            }
            .navigationTitle("Profile")
           


    }
        .onAppear{
            Task{
                do{
                    let reusult = Auth.auth().currentUser?.displayName
                    player.firstName = reusult ?? "Unkown Name  "
                }
                catch
                {
                    print("Error: can not find user name")
                }
                
            }
        }
        
        .alert("This feature is not yet available... Stay tuned for the OffSeason V1.1 update \n 🤟🏿⚡️",isPresented: $showAlert){
            Button ("Ok", role: .cancel) {}
            
        }
        .fullScreenCover(isPresented:$showSignInView) {
            NavigationStack{
                LoginView(player: Player())
            }
        }
    }
    
    
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
//    func signOut(){
//         do {
//             try Auth.auth().signOut()
//             // Handle successful sign-out
//             // For example, navigate to a login screen
//             showLogin.toggle()
//         } catch let signOutError as NSError {
//             // Handle sign-out error
//             print("Error signing out: \(signOutError.localizedDescription)")
//         }
//     }
}
struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(player: Player( firstName: "Blade", lastName:"Icewood", userName: "@BWood", email: "BLadeIcewood@gmail.com", age: Date(), gender: "Male"), showSignInView: .constant(false))
            .environmentObject(AuthenticationViewModel())
    }
}
