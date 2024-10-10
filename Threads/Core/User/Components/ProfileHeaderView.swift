//
//  ProfileHeaderView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-07.
//

import SwiftUI

struct ProfileHeaderView: View {
    var user: User?
    
    var body: some View {
        HStack(alignment: .top) {
            //Content
            VStack(alignment: .leading, spacing: 12) {
                //Name and username
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.fullName ?? "Full Name")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("@\(user?.username ?? "Username")")
                        .font(.subheadline)
                }
                
                //Bio and followers count
                if let bio = user?.bio{
                    Text(bio)
                        .font(.footnote)
                }
                
                Text("981m followers")
                    .foregroundStyle(.gray)
                    .font(.caption)
            }//VStack
            
            Spacer()
            
            CircularProfileImageView(user: user, size: .medium)
        }//HStack
    }
}

#Preview {
    ProfileHeaderView(user: DeveloperPreview.shared.user)
}
