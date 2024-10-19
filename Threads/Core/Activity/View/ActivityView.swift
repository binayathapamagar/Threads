//
//  ActivityView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct ActivityView: View {
    @State private var selectedTab: String = "All"
    let tabs = ["All", "Follows", "Replies", "Reposts"]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 6) {
                        ForEach(tabs, id: \.self) { tab in
                            Text(tab)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: 100, height: 36)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(
                                            selectedTab == tab ? Color.appPrimary : Color.clear
                                        )
                                )
                                .foregroundColor(
                                    selectedTab == tab ? .appSecondary : .primary
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(
                                            Color(
                                                selectedTab == tab ? .appPrimary : .systemGray4
                                            ),
                                            lineWidth: 1
                                        )
                                )
                                .onTapGesture {
                                    selectedTab = tab
                                }
                        }//ForEach
                    }//HStack
                    .padding(.horizontal)
                }//ScrollView
                .scrollIndicators(.hidden)
                .padding(.top, 12)
                
                ScrollView {
                    LazyVStack {
                        ForEach(0...10, id: \.self) { user in
                            VStack {
                                ThreadCellView(thread: DeveloperPreview.shared.thread)
                            }//VStack
                            .padding(.vertical, 4)
                        }//ForEach
                    }//LazyVStack
                }//ScrollView
                .scrollIndicators(.hidden)
            }//VStack
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Activity")
                        .bold()
                        .font(.largeTitle)
                        .padding(.top, 8)
                }
            }
        }//NavigationStack
    }
}

#Preview {
    ActivityView()
}
