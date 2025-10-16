import Firebase
import Foundation

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()

    init() {
        Task { try await fetchTweets() }
    }

    @MainActor
    func fetchTweets() async throws {
        self.tweets = try await TweetService.fetchTweets()
        try await fetchUserDataForTweets()
    }

    private func fetchUserDataForTweets() async throws {
        for i in 0..<tweets.count {
            let tweet = tweets[i]
            let ownerUid = tweet.ownerUid
            let tweetUser = try await UserService.fetchUser(withUid: ownerUid)

            tweets[i].user = tweetUser
        }
    }
  

}
