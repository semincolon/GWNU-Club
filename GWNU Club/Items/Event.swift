import SwiftUI

struct Event: Identifiable {
    var id: Int             // 고유 ID
    var title: String       // 이벤트명
    var startDate: String     // 시작날짜
    var endDate: String?      // 종료날짜(하루만 할 수도 있으므로 Optional)
    var campus: Campus      // 열리는 캠퍼스
    var view: Int           // 글 조회수
    var images: [Image]?    // 관련 사진
}
