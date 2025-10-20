import Firebase
import FirebaseAuth
import Foundation

class CreateTweetViewModel: ObservableObject {

    func uploadTweet(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let tweet = Tweet(
            ownerUid: uid,
            caption: caption,
            timestamp: Timestamp(),
            likes: 0
        )
        try await TweetService.uploadTweet(_tweet: tweet)

    }
}
