//
//  ProfileView.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 11.10.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import Kingfisher

struct ProfilePostComponent: View {
    let post: Post
    
    var body: some View {
        VStack {
            Divider()
                .padding(.horizontal)
            
            HStack {
                
                
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
        
    }
}


struct ProfileView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @StateObject var profileViewModel = ProfileViewModel()
    
    @State private var showLogOutOptions = false
    @State private var showAddPostView = false
    @State private var profileImage: UIImage?
    @State private var isLoadingProfileImage = false
    @State private var isRefreshing = false
    @State private var isInitialized = false
    
    var email: String? {
        Auth.auth().currentUser?.email
    }
    
    var uid: String? {
        Auth.auth().currentUser?.uid
    }
    
    func getProfileImage() {
        guard let uid = uid else {return}
        let storageRef = Storage.storage().reference(withPath: uid)
        storageRef.getData(maxSize: 3 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error while downloading profile image, \(error.localizedDescription)")
                return
            }
            guard let imageData = data, let image = UIImage(data: imageData) else {return}
            DispatchQueue.main.async {
                profileImage = image
                isLoadingProfileImage = false
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack {
                    Image(uiImage: profileImage ?? UIImage(systemName: "person.circle")!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 44)
                                .stroke(Color.black, lineWidth: 1)
                        }
                        .padding()
                    
                    VStack{
                        Text((email ?? "").components(separatedBy: "@").first ?? "")
                            .font(.largeTitle)
                            .multilineTextAlignment(.leading)
                    } //: VStack
                    
                    Spacer()
                }
                
                
                
            } //: VStack
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showLogOutOptions.toggle()
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 24))
                            .bold()
                            .foregroundStyle(.black)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddPostView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundStyle(.blue)
                    }
                }
            }
            .actionSheet(isPresented: $showLogOutOptions) {
                ActionSheet(title: Text("Settings"),
                            message: Text("What do you want to do?"),
                            buttons: [
                                .destructive(Text("Sign Out"), action: {
                                    loginViewModel.handleSignOut()
                                }),
                                .cancel()
                            ]
                )
            }
            .sheet(isPresented: $showAddPostView) {
                AddPostView()
            }
            .onAppear(perform: {
                profileViewModel.posts = [Post]()
                profileViewModel.getUserPosts()
                
                if !isInitialized {
                    isLoadingProfileImage = true
                    getProfileImage()
                    isInitialized = true
                }
            })
        } //: Nav
    }
    
    
}

#Preview {
    ProfileView(loginViewModel: LoginViewModel())
}
