import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()

    let user = User(
        id: NSUUID().uuidString,
        fullname: "Ankit Singh",
        email: "Ankit@gmail.com",
        username: "anikit_stp"
    )
}
