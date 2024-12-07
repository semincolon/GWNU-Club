import SwiftUI

struct ClubListView: View {
    
    private var gridItems: [GridItem] = [
        GridItem(spacing: 16), GridItem()
    ]
    
    private var clubs: [Club] = [
        Club(id: 1, name: "동아리1", hashtags: ["사진", "친목"]),
        Club(id: 2, name: "동아리2", hashtags: ["사진", "친목"]),
        Club(id: 3, name: "동아리3", hashtags: ["사진", "친목"]),
        Club(id: 4, name: "동아리4", hashtags: ["사진", "친목"]),
        Club(id: 5, name: "동아리5", hashtags: ["사진", "친목"]),
        Club(id: 6, name: "동아리6", hashtags: ["사진", "친목"]),
        Club(id: 7, name: "동아리7", hashtags: ["사진", "친목"]),
        Club(id: 8, name: "동아리8", hashtags: ["사진", "친목"]),
        Club(id: 9, name: "동아리9", hashtags: ["사진", "친목"]),
        Club(id: 10, name: "동아리10", hashtags: ["사진", "친목"]),
        Club(id: 11, name: "동아리12", hashtags: ["사진", "친목"]),
        Club(id: 12, name: "동아리12", hashtags: ["사진", "친목"])
    ]
    
    @State private var searchClub: String = ""
    @State private var selectedCampus: Campus = Campus.all
    @State private var selectedType: ClubType = ClubType.all
    
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
                            ForEach(Campus.allCases) {
                                Text($0.rawValue)
                            }
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
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(clubs, id: \.id) { club in
                            
                            NavigationLink(destination: ClubDetailView(club: club)) {
                                ClubItem(club: club)
                                    
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .ignoresSafeArea(edges: .top)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .tint(.white)
    }

}

struct ClubItem: View {
    var club: Club
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "matter.logo")
                .resizable()
                .frame(height: 120)
                .scaledToFill()
                .border(.gray, width: 1)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "apple.logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                    
                    Text(club.name)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("  #\(club.hashtags[0])  ")
                        .font(.body)
                        .fontWeight(.medium)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.tagColor))
                    
                    Spacer()
                    
                    Text("  #\(club.hashtags[1])  ")
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

#Preview {
    ClubListView()
}
