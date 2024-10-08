//
//  UserContentListView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-07.
//

import SwiftUI

struct UserContentListView: View {
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    var body: some View {
        VStack {
            
            //Profile Thread Filter
            HStack {
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(
                                selectedFilter == filter ? .semibold : .regular
                            )
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundStyle(.appPrimary)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .matchedGeometryEffect(id: "sharedID", in: animation)
                        } else {
                            Rectangle()
                                .foregroundStyle(.clear)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                        }
                    }//VStack
                    .onTapGesture {
                        withAnimation(.spring) {
                            selectedFilter = filter
                        }
                    }
                }//ForEach
            }//HStack
            
            //Content List
            LazyVStack {
                ForEach(0...10, id: \.self) { thread in
                    ThreadCellView()
                }//ForEach
            }//LazyVStack
        }//VStack
    }
}

#Preview {
    UserContentListView()
}
