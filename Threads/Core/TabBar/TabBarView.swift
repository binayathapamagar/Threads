//
//  TabBar.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @State private var showCreateThreadView = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView(showCreateThread: $showCreateThreadView)
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }
                .tag(2)
            
            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .tag(3)
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .tag(4)
        }
        .onChange(of: selectedTab, { oldValue, newValue in
            if newValue == 2 {
                triggerDoubleHapticFeedback()
                showCreateThreadView = true
                selectedTab = oldValue
            }
        })
        .sheet(isPresented: $showCreateThreadView, content: {
            CreateThreadView()
        })
        .tint(.appPrimary)
    }
}

#Preview {
    TabBarView()
}

extension TabBarView {
    
    private func triggerDoubleHapticFeedback() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
        
        // Dispatch another haptic feedback after a slight delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            impactMed.impactOccurred()
        }
    }
    
}
