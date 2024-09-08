//
//  ProfileView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct ProfileView: View {

    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    var body: some View {
        ScrollView {
            //Header
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    //Content
                    VStack(alignment: .leading, spacing: 12) {
                        //Name and username
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Leo Andres Messi")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("LeoMessi")
                                .font(.subheadline)
                        }
                        
                        //Bio and followers count
                        Text("Professional player of Inter Miami FC & Argentina")
                            .font(.footnote)
                        
                        Text("981m followers")
                            .foregroundStyle(.gray)
                            .font(.caption)
                    }//VStack
                    
                    Spacer()
                    
                    CircularProfileView()
                }//HStack
                
                Button(action: {}, label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 32)
                        .background(.black)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                })
                
                //User content list view
                VStack {
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
                                        .foregroundStyle(.black)
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
                
            }//VStack
        }//ScrollView
        .scrollIndicators(.hidden)
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView()
}
