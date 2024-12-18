import SwiftUI

struct ClubListView: View {
    
    private var gridItems: [GridItem] = [
        GridItem(spacing: 16), GridItem()
    ]
    
    @State private var searchClub: String = ""
    @State private var selectedCampus: Campus = Campus.all
    @State private var selectedType: ClubType = ClubType.all
    @State private var clubs: [Club] = []
    
    @StateObject private var clubViewModel: ClubViewModel = .init() // 의존성 주입되므로 나중에 수정할 부분
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("동아리")
                            .font(.blackHanSans48)
                            .foregroundStyle(.white)
                            .shadow(radius: 9, x: 0, y: 5)
                        
                        SearchBar(hint: "동아리명으로 검색", input: $searchClub)
                    }
                    
                    VStack {
                        // 캠퍼스 선택 Picker
                        Picker("Campus", selection: $selectedCampus) {
                            Text("전체").tag(Campus.all)
                            Text("강릉캠퍼스").tag(Campus.gangneung)
                            Text("원주캠퍼스").tag(Campus.wonju)
                        }
                        .pickerStyle(.segmented)
                        .background(RoundedRectangle(cornerRadius: 7).foregroundStyle(Color(white: 1, opacity: 0.2)))
                        .frame(width: 300)
                        
                        // 동아리 분야 선택 Picker
                        Picker("Type", selection: $selectedType) {
                            ForEach(ClubType.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .background(RoundedRectangle(cornerRadius: 7).foregroundStyle(Color(white: 1, opacity: 0.2)))
                    }
                    .padding(.top, 10)
                }
                .padding()
                .safeAreaPadding(.top, 45)
                .background(Rectangle().fill(Color.primaryColor))
                
                // 동아리 목록
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(clubs, id: \.id) { club in
                                NavigationLink(destination: ClubDetailView(club: club)) {
                                    ClubItem(club: club)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        .id("TOP")
                    }
                    .onChange(of: selectedCampus) { // 같은 내용의 코드를 하나로 단축시키는 방법이 없을까?
                        proxy.scrollTo("TOP", anchor: .top)
                        filterClubs()
                    }
                    .onChange(of: selectedType) {
                        proxy.scrollTo("TOP", anchor: .top)
                        filterClubs()
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .tint(.white)
        .onAppear {
            Task {
                try await clubViewModel.fetchClubs()
                clubs = clubViewModel.clubs
            }
        }
    }
        
    func filterClubs() {
        var temp = clubs
        switch selectedCampus {
        case .gangneung:
            temp = clubViewModel.clubs.filter { $0.campus == .gangneung }
        case .wonju:
            temp = clubViewModel.clubs.filter { $0.campus == .wonju }
        default:
            temp = clubViewModel.clubs
        }
        
        switch selectedType {
        case .religion: clubs = temp.filter { $0.clubType == ClubType.religion.rawValue }
        case .exercise: clubs = temp.filter { $0.clubType == ClubType.exercise.rawValue }
        case .show: clubs = temp.filter { $0.clubType == ClubType.show.rawValue }
        case .study: clubs = temp.filter { $0.clubType == ClubType.study.rawValue }
        case .hobby: clubs = temp.filter { $0.clubType == ClubType.hobby.rawValue }
        case .other: clubs = temp.filter { $0.clubType == ClubType.other.rawValue }
        default: clubs = temp
        }
    }
}


struct ClubItem: View {
    var club: Club
    
    var body: some View {
        VStack {
            ThumbnailImage(thumbnailURL: club.imageURL + "/images/1.jpeg")
            
            VStack(spacing: 5) {
                HStack {
                    LogoImage(logoURL: club.imageURL + "/logo.jpg")
                    
                    Text(club.clubName)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(club.campus == .gangneung ? "강릉캠퍼스" : "원주캠퍼스")
                        .font(.footnote)
                }
                
                HStack {
                    Text(" #\(club.hashtag1) ")
                        .font(.callout)
                        .fontWeight(.medium)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.tagColor))
                    
                    Text(" #\(club.hashtag2) ")
                        .font(.body)
                        .fontWeight(.medium)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.tagColor))
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .border(.gray, width: 2)
    }
}

struct LogoImage: View {
    var logoURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: logoURL)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            }
        }
    }
}

//#Preview {
//    ClubListView()
//}
