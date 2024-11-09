import SwiftUI

struct ClubDetailView: View {
    var club: Club
    
    var body: some View {
        VStack {
            ZStack {
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(club.name)
                            .font(.blackHanSans48)
                            .foregroundStyle(.white)
                            .shadow(radius: 9, x: 0, y: 5)
                        
                        HStack(spacing: 16) {
                            Text("  #\(club.hashtags[0])  ")
                                .font(.body)
                                .fontWeight(.medium)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color.tagColor))
                            
                            Text("  #\(club.hashtags[1])  ")
                                .font(.body)
                                .fontWeight(.medium)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color.tagColor))
                        }
                    }
                    
                    Spacer()
                    
                    if club.urlKakao != nil {
                        Image("logo_kakao")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 48)
                    }
                    
                    if club.urlInstagram != nil {
                        Image("logo_instagram")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 48)
                    }
                }
            }
            .padding()
            .safeAreaPadding(.top, 80)
            .background(Rectangle().fill(Color.primaryColor))            
            
            ScrollView {
                Text("동아리 내용")
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    ClubDetailView(club: Club(id: 1, name: "동아리1", hashtags: ["사진", "친목"]))
}
