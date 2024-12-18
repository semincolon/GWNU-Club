import SwiftUI

struct ThumbnailImage: View {
    var thumbnailURL: String
    
    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: thumbnailURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: geometry.size.width, height: 200)
                        .border(.gray, width: 2)
                } else if phase.error != nil {
                    Image("Splash")
                        .resizable()
                        .frame(width: geometry.size.width, height: 200)
                        .border(.gray, width: 2)
                } else {
                    ProgressView()
                        .foregroundStyle(.red)
                        .frame(width: geometry.size.width, height: 200)
                }
            }
        }
        .frame(height: 200) // GeometryReader의 크기 제한
    }
}
