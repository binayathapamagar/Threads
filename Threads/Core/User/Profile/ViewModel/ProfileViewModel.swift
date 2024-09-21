//
//  ProfileViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-20.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print(#function, "DEBUG: User object in view model using combine is \(user)")
        }.store(in: &cancellables)
    }
    
}
