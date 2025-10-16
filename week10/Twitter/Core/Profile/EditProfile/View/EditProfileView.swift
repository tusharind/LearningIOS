import PhotosUI
import SwiftUI

struct EditProfileView: View {
    let user: User
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivate = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditProfileViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])

                VStack {
                    //name and profile image
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)

                            Text(user.fullname)
                        }

                        Spacer()

                        PhotosPicker(selection: $viewModel.selectedItem) {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircularProfileImageView(user: nil)
                            }
                        }

                    }

                    Divider()

                    //bio field

                    VStack(alignment: .leading) {
                        Text("Bio")
                            .fontWeight(.semibold)

                        TextField("Enter Your Bio", text: $bio, axis: .vertical)
                    }

                    Divider()

                    VStack(alignment: .leading) {
                        Text("Link")
                            .fontWeight(.semibold)

                        TextField("Add Link", text: $link)
                    }

                    Divider()

                    Toggle("Private Profile", isOn: $isPrivate)
                }
                .font(.footnote)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        Task { try await viewModel.updateUserData() }
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
    }
}
