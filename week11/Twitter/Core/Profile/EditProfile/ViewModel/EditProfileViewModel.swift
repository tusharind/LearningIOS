import Firebase
import PhotosUI
import SwiftUI

class EditProfileViewModel: ObservableObject {

    private var uiImage: UIImage?  // store UIImage here
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task { await loadImage() } }
    }
    @Published var profileImage: Image?

    func updateUserData() async throws {
        print("DEBUG: Update User Data Here")
        try await updateProfileImage()  // make sure to call your upload
    }

    @MainActor
    private func loadImage() async {
        guard let item = selectedItem else { return }

        guard let data = try? await item.loadTransferable(type: Data.self)
        else { return }
        guard let uiImage = UIImage(data: data) else { return }

        self.uiImage = uiImage  // store UIImage for uploading
        self.profileImage = Image(uiImage: uiImage)  // for SwiftUI display
    }

    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageURL = try await ImageUploader.uploadImage(image) else {
            return
        }
        try await UserService.shared.updateUserProfileImage(
            withImageURL: imageURL
        )
    }
}
