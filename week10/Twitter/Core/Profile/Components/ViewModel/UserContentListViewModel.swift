import Foundation

class UserContentListViewModel: ObservableObject {
    @Published var tweets = [Tweet]()

    let user: User

    init(user: User) {
        self.user = user
        Task { try await fetchUserThreads() }
    }

    @MainActor
    func fetchUserThreads() async throws {
        var tweets = try await TweetService.fetchUserTweets(uid: user.id)

        for i in 0..<tweets.count {
            tweets[i].user = self.user
        }

        self.tweets = tweets
    }
}
