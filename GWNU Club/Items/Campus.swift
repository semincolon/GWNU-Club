enum Campus: String, CaseIterable, Identifiable {
    case all = "전체"
    case gangneung = "강릉캠퍼스"
    case wonju = "원주캠퍼스"
    var id: Self { self }
}
