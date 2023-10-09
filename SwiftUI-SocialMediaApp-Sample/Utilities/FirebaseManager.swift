//
//  FirebaseManager.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 9.10.2023.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        auth = Auth.auth()
        storage = Storage.storage()
        firestore = Firestore.firestore()
        
        super.init()
    }
}
