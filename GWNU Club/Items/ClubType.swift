enum ClubType: String, CaseIterable, Identifiable {
    case all = "전체"
    case religion = "종교"
    case exercise = "운동"
    case show = "공연"
    case other = "기타"
    var id: Self { self }
}
