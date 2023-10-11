//
//  AddPostViewModel.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 11.10.2023.
//

import Foundation
import Firebase

class AddPostViewModel {
    func addPost(name: String, postTitle: String, image: UIImage?, date: Date) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Firestore.firestore().collection("posts").document()
        ref.setData([
            "name": name,
            "title": postTitle,
            "id": ref.documentID as String,
            "timestamp": date,
            "useruid": uid
        ])
    }
    
    func savePostImage(image: UIImage, documentID: String) {
        let ref = FirebaseManager.shared.storage.reference(withPath: documentID)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, error in
                
        }
    }
    
}
