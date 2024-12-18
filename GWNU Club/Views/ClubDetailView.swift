import SwiftUI

struct ClubDetailView: View {
    // 의존성 주입되는 부분이라 개선 필요
    @StateObject private var descriptionViewModel: DescriptionViewModel = .init()
    @StateObject private var imagesURLViewModel: ImagesURLViewModel = .init()
    
    var club: Club
    
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(club.clubName)
                            .font(.blackHanSans48)
                            .foregroundStyle(.white)
                            .shadow(radius: 9, x: 0, y: 5)
                        
                        HStack(spacing: 16) {
                            Text("  #\(club.hashtag1)  ")
                                .font(.body)
                                .fontWeight(.medium)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color.tagColor))
                            
                            Text("  #\(club.hashtag2)  ")
                                .font(.body)
                                .fontWeight(.medium)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color.tagColor))
                        }
                    }
                    
                    Spacer()
                    
                    if club.urlKakao != "" {
                        Link(destination: URL(string: club.urlKakao)!) {
                            Image("logo_kakao")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: 48, height: 48)
                        }
                    } else {
                        Image("logo_kakao")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 48)
                            .opacity(0.5)
                    }
                    
                    if club.urlInstagram != "" {
                        Link(destination: URL(string: club.urlInstagram)!) {
                            Image("logo_instagram")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: 48, height: 48)
                        }
                    } else {
                        Image("logo_instagram")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 48)
                            .opacity(0.5)
                    }
                }
            }
            .padding()
            .safeAreaPadding(.top, 80)
            .background(Rectangle().fill(Color.primaryColor))
            
            ScrollView {
                ImagesView(urlPrefix: club.imageURL + "/images/")
                    .environmentObject(imagesURLViewModel)
                
                Text(descriptionViewModel.description?.description ?? "소개 글이 없습니다.")
                    .padding(.horizontal)
            }
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            Task {
                try await descriptionViewModel.fetchDescription(url: APIConstants.clubListURL + "/\(club.id)")
            }
            Task {
                try await imagesURLViewModel.fetchAllImages(url: APIConstants.clubListURL + "/\(club.id)" + "/images")
            }
        }
    }
}

//#Preview {
//    ClubDetailView(club: Club(id: 1, clubName: "동아리1", hashtag1: "사진", hashtag2: "친목"))
//}
