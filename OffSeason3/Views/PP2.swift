//
//  PP2.swift
//  OffSeason3
//
//  Created by Sean Carter on 6/21/23.
//

import SwiftUI

struct PP2: View {
    var body: some View {
                ScrollView {
                    VStack(spacing: 20) {
                        ProfileCoverImage()
                        
                        VStack(alignment: .leading, spacing: 20) {
                            ProfileInfo()
                            
                            Divider()
                            
                            PostsSection()
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationBarTitle("Profile", displayMode: .large)
            }
        }

        struct ProfileCoverImage: View {
            var body: some View {
                Image("coverImage")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
            }
        }

        struct ProfileInfo: View {
            var body: some View {
                VStack(alignment: .leading, spacing: 10) {
                    Text("John Doe")
                        .font(.title)
                    
                    Text("UI/UX Designer")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Games attened")
                                .font(.headline)
                            Text("1,234")
                                .font(.subheadline)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Games Created")
                                .font(.headline)
                            Text("5,678")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }

        struct PostsSection: View {
            var body: some View {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(1...5, id: \.self) { postID in
                        PostRow(postID: postID)
                    }
                }
            }
        }

        struct PostRow: View {
            let postID: Int
            
            var body: some View {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image("profileImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text("John Doe")
                                .font(.headline)
                            Text("Posted 2 hours ago")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    
                    Text("This is post \(postID)")
                }
            }
        }



struct PP2_Previews: PreviewProvider {
    static var previews: some View {
        PP2()
    }
}
