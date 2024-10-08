//
//  User.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-20.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let username: String
    let fullName: String
    let email: String
    let joinedDate: String
    var isPrivate: Bool = false
    var profileImageUrl: String?
    var bio: String?
}
