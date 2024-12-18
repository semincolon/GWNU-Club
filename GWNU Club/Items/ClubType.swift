enum ClubType: String, CaseIterable, Identifiable {
    case all = "전체"
    case religion = "종교"
    case exercise = "운동"
    case show = "공연"
    case study = "학술"
    case hobby = "취미"
    case other = "기타"
    var id: Self { self }
}
