import SwiftUI

struct Event: Identifiable, Codable {
    var id: Int             // 고유 ID
    var title: String       // 이벤트명
    var startDate: String   // 시작날짜
    var endDate: String     // 종료날짜
    var campus: Campus      // 열리는 캠퍼스
    var view: Int           // 글 조회수
    var thumbnailImage: String // 썸네일 이미지 파일명
}
