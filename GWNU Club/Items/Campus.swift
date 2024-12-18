enum Campus: String, Codable, CaseIterable, Identifiable {
    case all
    case gangneung = "GANGNEUNG"
    case wonju = "WONJU"
    
    var id: Self { self }
}
