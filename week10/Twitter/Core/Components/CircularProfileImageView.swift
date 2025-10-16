import Kingfisher
import SwiftUI

struct CircularProfileImageView: View {
    var user: User?

    init(user: User?) {
        self.user = user
    }

    var body: some View {
        if let imageURL = user?.profileImageURL {
            KFImage(URL(string: imageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())

        } else {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }
    }
}
