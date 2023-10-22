//
//  SearchView.swift
//  SwiftUI-SocialMediaApp-Sample
//
//  Created by ekayaint on 19.10.2023.
//

import SwiftUI

struct SearchView: View {
    @State private var text = ""
    @ObservedObject var postsViewModel: PostsViewModel
    
    var body: some View {
        VStack {
            HStack {
                withAnimation(.default) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                            .padding(.leading, 8)
                        
                        TextField("Search", text: $text)
                    } //: HStack
                    .padding(.horizontal, 8)
                    .background(Color.gray)
                    .cornerRadius(8)
                }
                
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.blue)
                    }
                    .padding(.trailing, 8)
                    .transition(.move(edge: .trailing))
                } //: if
            } //: HStack
            .transition(.move(edge: .top))
            
            Spacer()
            
            ScrollView {
                ForEach(postsViewModel.posts.filter({post in
                    text.isEmpty ? true : post.name.localizedStandardContains(text)
                })) {post in
                    PostComponent(post: post)
                        .padding(.bottom)
                }
            } //: ScrollView
            
        } //: VStack
        .padding()
    }
}

/*#Preview {
    SearchView(postsViewModel: PostsViewModel())
}*/
