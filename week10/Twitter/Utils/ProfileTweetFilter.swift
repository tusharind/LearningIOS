import Foundation

enum ProfileTweetFilter: Int, CaseIterable, Identifiable {  //it conforms to the case iterable protocol so we can loop theough it
    case tweets
    case replies

    var title: String {
        switch self {
        case .tweets: return "tweets"
        case .replies: return "replies"
        }
    }

    var id: Int { return self.rawValue }
}
