//
//  LoginViewModel.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 9.10.2023.
//

import Foundation
import Firebase
import FirebaseStorage

class LoginViewModel: ObservableObject {
    @Published var isCurrentlyLoggedOut = false
    
    init() {
        isCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
    }
    
    func loginUser(email: String, password: String) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login user \(error)")
                return
            }
            
            self.isCurrentlyLoggedOut = false
        }
    }
}
