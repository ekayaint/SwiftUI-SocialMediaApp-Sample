//
//  PostsView.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 11.10.2023.
//

import SwiftUI
import Kingfisher

struct PostComponent: View {
    let post: Post
    var postsViewModel = PostsViewModel()
    @State private var profileImage: UIImage?
    @State private var isLoadingImage = false
    
    var body: some View {
        VStack {
            Divider()
                .padding(.horizontal)
            
            HStack {
                if isLoadingImage {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipped()
                        .cornerRadius(50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 44)
                                .stroke(Color(.label), lineWidth: 1)
                        }
                        .padding(.leading)
                } else if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipped()
                        .cornerRadius(50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 44)
                                .stroke(Color(.label), lineWidth: 1)
                        }
                        .padding(.leading)
                    
                } //: if
                
                Text(post.name)
                    .padding(.vertical, 2)
                    .padding(.horizontal)
                    .foregroundStyle(.blue)
                
                Spacer()
                
            } //: HStack
            
            HStack{
                Text(post.postTitle)
                    .bold()
                Spacer()
                Text(post.timestamp.formatted())
                    .font(.caption2)
            } //: HStack
            .padding()
            
            if let url = URL(string: post.imageURL) {
                KFImage(url)
            }
        } //: VStack
        .onAppear(perform: {
            isLoadingImage = true
            postsViewModel.getUserProfileImage(userUID: post.userUID) { image in
                profileImage = image
                isLoadingImage = false
            }
        })
    }
}

struct PostsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PostsView()
}
