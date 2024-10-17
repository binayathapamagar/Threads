//
//  CircularProfileview.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-07.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xlarge

    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 64
        case .xlarge: return 80
        }
    }
}

struct CircularProfileImageView: View {
    let user: User?
    let size: ProfileImageSize
    
    init(user: User?, size: ProfileImageSize) {
        self.user = user
        self.size = size
    }
    
    var body: some View {
        if let profileImageUrl = user?.profileImageUrl {
            //Using the KingFisher package as it has image caching feature which the native AsyncImage doesn't
            KFImage(URL(string: profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .tint(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: DeveloperPreview.shared.user, size: .small)
}
