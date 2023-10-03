//
//  LoginView.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 3.10.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    @State private var image: UIImage?
    @State private var loginStatusMessage = ""
    @State private var shouldShowImagePicker = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                
                Circle()
                    .scale(1.8)
                    .foregroundStyle(.white)
                    .opacity(0.15)
                
                Circle()
                    .scale(1.4)
                    .foregroundStyle(.white)
                
                VStack(spacing: 16) {
                    Text(isLoginMode ? "Login" : "Create Username")
                } //: VStack
                .padding()
                
            } //: ZStack
        } //: Nav
    }
}

#Preview {
    LoginView()
}
