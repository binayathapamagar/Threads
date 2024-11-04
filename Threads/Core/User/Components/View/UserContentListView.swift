//
//  UserContentListView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-07.
//

import SwiftUI

struct UserContentListView: View {
    @StateObject var viewModel: UserContentListViewModel
    @Namespace var animation
    
    init(user: User) {
        self._viewModel = StateObject(
            wrappedValue: UserContentListViewModel(user: user)
        )
    }
    
    var body: some View {
        VStack {
            //Profile Thread Filter
            ZStack(alignment: .bottom) {
                Rectangle()
                    .foregroundStyle(.dividerBG)
                    .frame(maxWidth: .infinity, maxHeight: 0.4)
                
                HStack {
                    ForEach(ProfileThreadFilter.allCases) { filter in
                        VStack {
                            Text(filter.title)
                                .font(.subheadline)
                                .fontWeight(
                                    viewModel.selectedFilter == filter ? .semibold : .regular
                                )
                            
                            if viewModel.selectedFilter == filter {
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
                            withAnimation(.smooth) {
                                viewModel.updateFilter(with: filter)
                            }
                        }
                    }//ForEach
                }//HStack
                
            }//ZStack
            
            //Content List
            if viewModel.threads.isEmpty {
                Spacer()
                Text(viewModel.emptyMessage)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.icon)
                    .padding()
                Spacer()
            } else {
                LazyVStack {
                    ForEach(viewModel.threads) { thread in
                        ThreadCellView(thread: thread)
                    }//ForEach
                }//LazyVStack
            }
        }//VStack
    }
}

#Preview {
    UserContentListView(user: DeveloperPreview.shared.user)
}
