//
//  ExploreView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var searchText = ""
    @StateObject private var viewModel = ExploreViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.users) { user in
                        NavigationLink(value: user) {
                            VStack {
                                UserCellView(user: user)
                                
                                Divider()
                            }//VStack
                            .padding(.vertical, 4)
                        }
                    }//ForEach
                }//LazyVStack
            }//ScrollView
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search")
            .tint(.appPrimary)
        }//NavigationStack
    }
}

#Preview {
    ExploreView()
}
