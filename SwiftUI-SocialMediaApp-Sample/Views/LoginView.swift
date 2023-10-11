//
//  LoginView.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 3.10.2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    @State private var image: UIImage?
    @State private var loginStatusMessage = ""
    @State private var shouldShowImagePicker = false
    
    private func handleAction() {
        if isLoginMode {
            loginViewModel.loginUser(email: email, password: password)
        } else {
            if let image = image {
                loginViewModel.createNewAccount(email: email, password: password, image: image)
            } else {
                self.loginStatusMessage = "Choose an image first!"
            }
        }
    }
    
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
                        .font(.largeTitle)
                        .bold()
                    
                    
                    if !isLoginMode {
                        Button{
                            shouldShowImagePicker.toggle()
                        } label: {
                            VStack{
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                        .foregroundStyle(.black)
                                } //: if
                            } //: VStack
                            .overlay {
                                RoundedRectangle(cornerRadius: 64)
                                    .stroke(Color.black, lineWidth: 3)
                            }
                        }
                    }
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.none)
                        .bold()
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .textInputAutocapitalization(.none)
                        .bold()
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Button {
                        handleAction()
                    } label: {
                        Text(isLoginMode ? "Login" : "Create Account")
                            .foregroundStyle(.white)
                            .padding(10)
                            .frame(width: 300, height: 50)
                            .background(.blue)
                            .cornerRadius(10)
                            .padding(.top, 20)
                    } //: Button
                    
                    HStack{
                        Text(isLoginMode ? "Don't have an account yet?": "Have an account?")
                        
                        Button {
                            isLoginMode.toggle()
                        } label: {
                            Text(isLoginMode ? "Create Account": "Login")
                        }
                    } //: HStack
                    
                    Text(loginStatusMessage)
                        .foregroundStyle(.red)
                    
                } //: VStack
                .padding()
                
            } //: ZStack
            .fullScreenCover(isPresented: $shouldShowImagePicker, content: {
                ImagePicker(image: $image)
                    .ignoresSafeArea()
            })
        } //: Nav
    }
    
    
}

#Preview {
    LoginView(loginViewModel: LoginViewModel())
}
