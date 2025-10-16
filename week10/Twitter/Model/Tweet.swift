
import Firebase
import FirebaseFirestore

struct Tweet: Identifiable, Codable {
    @DocumentID var tweetId:String?
    let ownerUid:String
    let caption:String
    let timestamp: Timestamp
    var likes:Int
    
    var user:User?
    
    var id:String {
        return tweetId ?? NSUUID().uuidString
    }
}


