import SwiftUI

struct FeedView: View {

    @StateObject var viewModel = FeedViewModel()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.tweets) { tweet in
                        ThreadCell(tweet: tweet)
                    }
                }

            }
            .refreshable {
                Task { try await viewModel.fetchTweets() }
            }
            .navigationTitle("Tweets")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {

                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
