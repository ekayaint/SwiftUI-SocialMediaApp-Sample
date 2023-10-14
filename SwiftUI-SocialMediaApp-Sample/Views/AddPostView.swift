//
//  AddPostView.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 11.10.2023.
//

import SwiftUI
import FirebaseAuth

struct AddPostView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var postTitle = ""
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var errorMessage = ""
    
    var addPostViewModel = AddPostViewModel()
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.blue)
                TextField("Share your thoughts...", text: $postTitle)
                    .padding(10)
                    .frame(maxWidth: .infinity)
            } //: HStack
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
            Button {
                isShowingImagePicker.toggle()
            } label: {
                VStack {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            }
                    } else {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 50))
                            .frame(width: 300, height: 300)
                            .foregroundStyle(.blue)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            }
                    } //: if
                } //: VStack
            } //: Button
            .padding()
            
            Text(errorMessage)
                .bold()
                .foregroundStyle(.red)
            
            Button {
                if selectedImage == nil {
                    errorMessage = "You must select image first"
                    return
                }
                
                guard let email = Auth.auth().currentUser?.email else {
                    print("Current user not authenticated.")
                    return
                }
                let name = email.components(separatedBy: "@").first ?? ""
                
                addPostViewModel.addPost(name: name, postTitle: postTitle, image: selectedImage, date: Date())
                
                dismiss()
                
            } label: {
                Text("Share")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            } //: Button
            
            Spacer()
            
        } //: VStack
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
}

#Preview {
    AddPostView()
}
