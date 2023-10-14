//
//  ProfileView.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 11.10.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var showLogOutOptions = false
    @State private var showAddPostView = false
    
    var body: some View {
        NavigationStack{
            VStack{
                
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
        } //: Nav
    }
}

#Preview {
    ProfileView(loginViewModel: LoginViewModel())
}
