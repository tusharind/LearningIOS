import SwiftUI

// MARK: - Profile Card Component
struct ProfileCard: View {
    var body: some View {
        VStack(spacing: 20) {

            // Profile Image
            Image("myImage")
                .resizable()
                .scaledToFill()  // maintains aspect ratio
                .frame(width: 100, height: 100)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                )
                .shadow(radius: 5)

            // Name
            Text("Tushar J")
                .font(.title2)
                .fontWeight(.bold)

            // Role
            Text("iOS Developer")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Contact Info
            HStack(spacing: 40) {
                Stats(title: "Posts", value: "120")
                Stats(title: "Followers", value: "2.5K")
                Stats(title: "Following", value: "300")
            }
            .padding(.vertical, 10)

        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}

// MARK: - Preview
struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard()
            .background(Color(.white))
    }
}
