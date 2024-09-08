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
                CircularProfileView()
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        
                        //Username
                        Text("LeoMessi")
                            .font(.footnote)
                        .fontWeight(.semibold)

                        Text("10m")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray2))
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        })
                    }//HStack
                    
                    //Thread content
                    Text("Hey guys, Leo from Argentina here.")
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
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 8)
                    
                }//VStack

            }//HStack
            
            Divider()
        }//VStack
        .padding(.top)
    }
}

#Preview {
    ThreadCellView()
}
