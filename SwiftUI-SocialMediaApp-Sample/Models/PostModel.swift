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
}
