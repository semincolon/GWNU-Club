import SwiftUI
import Foundation

struct Club: Identifiable, Codable {
    var id: Int
    var clubName: String
    var clubType: String
    var campus: Campus
    var imageURL: String
    var hashtag1: String
    var hashtag2: String
    var urlKakao: String
    var urlInstagram: String
    
    enum CodingKeys: String, CodingKey {
        case id, clubName, clubType, campus, imageURL, hashtag1, hashtag2, urlKakao, urlInstagram
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.clubName = try container.decode(String.self, forKey: .clubName)
        self.clubType = try container.decode(String.self, forKey: .clubType)
        self.campus = try container.decode(Campus.self, forKey: .campus)
        self.hashtag1 = try container.decode(String.self, forKey: .hashtag1)
        self.hashtag2 = try container.decode(String.self, forKey: .hashtag2)
        self.urlKakao = try container.decode(String.self, forKey: .urlKakao)
        self.urlInstagram = try container.decode(String.self, forKey: .urlInstagram)
        
        let originamImageURL = try container.decode(String.self, forKey: .imageURL)
        if campus == .gangneung {
            self.imageURL = APIConstants.imageURL + "/clubs/gangneung/\(originamImageURL)"
        } else {
            self.imageURL = APIConstants.imageURL + "/clubs/wonju/\(originamImageURL)"
        }
    }
}
