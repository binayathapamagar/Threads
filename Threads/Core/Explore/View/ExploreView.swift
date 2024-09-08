//
//  ExploreView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0...10, id: \.self) { user in
                        VStack {
                            UserCellView()
                            
                            Divider()
                        }//VStack
                        .padding(.vertical, 4)
                    }//ForEach
                }//LazyVStack
            }//ScrollView
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search")
        }//NavigationStack
    }
}

#Preview {
    ExploreView()
}
