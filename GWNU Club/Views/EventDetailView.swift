import SwiftUI

struct EventDetailView: View {
    @StateObject var descriptionViewModel: DescriptionViewModel = .init()
    @StateObject var imagesURLViewModel: ImagesURLViewModel = .init()
    
    var event: Event
    
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(event.title)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .shadow(radius: 9, x: 0, y: 5)
                        
                        Text("\(event.startDate) ~ \(event.endDate)   조회수 | \(event.view)")
                            .font(.caption)
                            .foregroundStyle(Color("TagColor"))
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .safeAreaPadding(.top, 80)
            .background(Rectangle().fill(Color.primaryColor))
            
            ScrollView {
                ImagesView(urlPrefix: APIConstants.imageURL + "/events/\(event.id)/")
                    .environmentObject(imagesURLViewModel)
                
                Text(descriptionViewModel.description?.description ?? "글이 존재하지 않습니다.")
                    .padding(.horizontal)
            }
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            Task {
                try await descriptionViewModel.fetchDescription(url: APIConstants.eventURL + "/\(event.id)")
            }
            Task {
                try await imagesURLViewModel.fetchAllImages(url: APIConstants.eventURL + "/\(event.id)/images")
            }
        }
    }
}

//#Preview {
//    EventDetailView()
//}
