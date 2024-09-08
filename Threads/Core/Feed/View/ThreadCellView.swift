//
//  ThreadCell.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-07.
//

import SwiftUI

struct ThreadCellView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Image(.minji)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        
                        //Username
                        Text("MinjiK")
                            .font(.footnote)
                        .fontWeight(.semibold)
                        
                        Spacer()
                        
                        //Time and button
                        Text("10m")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        })
                    }//HStack
                    
                    //Thread content
                    Text("Hey guys, Minji here from the KPOP group NewJeans")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    //Action buttons
                    HStack(spacing: 16) {
                        Button(action: {}, label: {
                            Image(systemName: "heart")
                        })
                        Button(action: {}, label: {
                            Image(systemName: "bubble.right")
                        })
                        Button(action: {}, label: {
                            Image(systemName: "arrow.rectanglepath")
                        })
                        Button(action: {}, label: {
                            Image(systemName: "paperplane")
                        })
                    }//HStack
                    .foregroundStyle(.black)
                    .padding(.vertical, 8)
                    
                }//VStack
            }//HStack
            
            Divider()
        }//VStack
        .padding()
    }
}

#Preview {
    ThreadCellView()
}
