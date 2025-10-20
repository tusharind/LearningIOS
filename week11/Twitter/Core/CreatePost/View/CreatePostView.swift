import SwiftUI

struct CreatePostView: View {
    @StateObject var viewModel = CreateTweetViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var caption = ""
 

    private var user: User? {
        return UserService.shared.currentUser
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView(user: user)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(user?.fullname ?? "")
                            .fontWeight(.semibold)

                        TextField(
                            "Start a thread",
                            text: $caption,
                            axis: .vertical
                        )
                    }
                    .font(.footnote)

                    Spacer()

                    if !caption.isEmpty {
                        Button {
                            caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("New Tweet")
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
                    Button("Post") {
                        Task {
                            try await viewModel.uploadTweet(caption: caption)
                        }
                        dismiss()
                    }
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
    }
}

