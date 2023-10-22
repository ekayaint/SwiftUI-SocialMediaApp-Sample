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
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 200)
            } else {
                ProgressView()
            } //: if
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
    @StateObject var postsViewModel = PostsViewModel()
    @State private var showSearchView = false
    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView {
                    ForEach(postsViewModel.posts) { post in
                        PostComponent(post: post)
                            .padding(.bottom)
                    } //: for
                } //: ScrollView
            } //: VStack
            .refreshable {
                postsViewModel.posts = [Post]()
                postsViewModel.fetchAllPosts()
            }
            .navigationTitle("Posts")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSearchView.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundStyle(.blue)
                } //: ToolbarItem
            } //: toolbar
            .sheet(isPresented: $showSearchView, content: {
                SearchView(postsViewModel: postsViewModel)
            })
        } //: Nav
    }
}

/*#Preview {
    //PostsView()
}*/
