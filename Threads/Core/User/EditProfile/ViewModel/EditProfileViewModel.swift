//
//  EditProfileViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-09.
//

import SwiftUI
import PhotosUI

class EditProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task { await loadPhotosImage() }
        }
    }
    @Published var username: String = ""
    @Published var bio: String = ""
    @Published var link: String = ""
    @Published var isPrivate: Bool = false
    @Published var profileImage: Image?
    private var uiImage: UIImage?
    
    func loadUserData(user: User) {
        self.username = user.username
        self.bio = user.bio ?? ""
        self.link = user.link ?? ""
        self.isPrivate = user.isPrivate
    }
    
    func updateUserData(with userId: String) async throws {
        try await updateProfileImage(with: userId)
    }
    
    @MainActor
    private func loadPhotosImage() async {
        guard let item = selectedItem else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
     
    private func updateProfileImage(with userId: String) async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try await ImageUploader.uploadImage(image, userId: userId) else { return }
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
    }
    
}
