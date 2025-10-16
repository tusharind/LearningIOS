import SwiftUI

struct ThreadCell: View {
    let tweet: Tweet
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView(user: nil)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(tweet.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)

                        Spacer()

                        Text("10m")
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))

                        Button {

                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }

                    }

                    Text(tweet.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)

                    HStack(spacing: 16) {
                        Button {

                        } label: {
                            Image(systemName: "heart")
                        }
                        Button {

                        } label: {
                            Image(systemName: "bubble.right")
                        }
                        Button {

                        } label: {
                            Image(systemName: "arrow.rectanglepath")
                        }
                        Button {

                        } label: {
                            Image(systemName: "paperplane")
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 8)

                }

            }
            .padding()
            Divider()
        }
    }
}
