//
//  EditProfileView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-09.
//

import SwiftUI

struct EditProfileView: View {
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivate = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea(edges: [.bottom, .horizontal])
                
                VStack {
                    //Name and profile pic
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)
                            
                            Text("Leo Andres Messi")
                        }
                        
                        Spacer()
                        
                        CircularProfileView()
                    }//HStack
                    
                    Divider()
                    
                    //Bio
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .fontWeight(.semibold)
                        
                        TextField("Enter your bio...", text: $bio, axis: .vertical)
                    }//VStack
                    
                    Divider()
                    
                    //Link
                    VStack(alignment: .leading) {
                        Text("Link")
                            .fontWeight(.semibold)
                        
                        TextField("Add link ...", text: $link)
                    }//VStack
                    
                    Divider()
                    
                    Toggle("Private Profile", isOn: $isPrivate)
                    
                }//VStack
                .font(.footnote)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .padding()
                
            }//ZStack
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {}
                        .font(.subheadline)
                        .foregroundStyle(.appPrimary)
                }//ToolbarItem
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {}
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.appPrimary)
                }//ToolbarItem
            }//Toolbar
        }//NavigationStack
    }
}

#Preview {
    EditProfileView()
}
