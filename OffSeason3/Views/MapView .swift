//
//  MapView .swift
//  OffSeason3
//
//  Created by Jacquese Whitson  on 5/29/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift


struct MapView: View {
    // how to put the collection of data from firebase into a variable
//    @FirestoreQuery(collectionPath: "spots") var spots: [Spot]
    @Environment(\.dismiss) private var dismiss
     @State private var sheetIsPresented = false
    var body: some View {
        NavigationStack {
            VStack{
                Text("P")
                
                
                
                 
            }
            //            List(spots){spot in
            //                NavigationLink{
            //                    SpotDetailView(spot: spot)
            //                }
            //            label:{
            //                Text(spot.name)
            //                    .font(.title2)
            //            }
            //            }
            //            .listStyle(.plain)
            //            .navigationTitle("Snack Spots")
            //            .navigationBarTitleDisplayMode(.inline)
            
            
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Sign Out"){
                        do {
                            try Auth.auth().signOut()
                            print("🪵⏩ log out successful ")
                            dismiss()
                        } catch{
                            print("🤬 Error: Could sign out")
                        }
                    }
                }
                ToolbarItemGroup(placement: .bottomBar){
                    Spacer()
                CreateButton
                    
                    
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack{
                    TestaddingDataView(game: Game())
                    
                }
            }
        }
//
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}




private extension MapView {
    var CreateButton: some View {
        Button{
            sheetIsPresented.toggle()
                }label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50)).foregroundColor(.red)
                        .shadow(color: Color.black.opacity (0.4), radius: 20,
                                 x: 0, y: 15)
                }
//                    .offset(y:-25
//                    )
            
        
        
    
    
    
}

}
