//
//  UserCellView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-07.
//

import SwiftUI

struct UserCellView: View {
    var body: some View {
        HStack {
            CircularProfileView()
            
            VStack(alignment: .leading) {
                Text("Messi")
                    .fontWeight(.semibold)
                
                Text("Leo Andres Messi")
                    .foregroundStyle(Color(.systemGray))
                
                Text("190m followers")
                    .fontWeight(.medium)
                    .padding(.vertical, 4)
            }//VStack
            .font(.footnote)
            .padding(.leading, 8)
            
            Spacer()
            
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
            
        }//HStack
        .padding(.vertical, 4)
        .padding(.horizontal)
    }
}

#Preview {
    UserCellView()
}
