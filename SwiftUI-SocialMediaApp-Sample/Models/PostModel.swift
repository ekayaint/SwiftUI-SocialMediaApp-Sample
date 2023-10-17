//
//  PostModel.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 14.10.2023.
//

import Foundation
import Firebase

struct Post: Decodable, Identifiable {
    var id: String
    var postTitle: String
    var timestamp: Date
    var name: String
    var userUID: String
    var imageURL: String
    
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.postTitle = data["postTitle"] as? String ?? ""
        self.timestamp = (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
        self.name = data["name"] as? String ?? ""
        self.userUID = data["userUID"] as? String ?? ""
        self.imageURL = data["imageURL"] as? String ?? ""
    }
}
