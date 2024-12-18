import SwiftUI

struct ImagesView: View {
    @EnvironmentObject var imagesURLViewModel: ImagesURLViewModel
    
    var urlPrefix: String
    
    var body: some View {
        TabView(selection: $imagesURLViewModel.selectedImage) {
            ForEach(imagesURLViewModel.imagesURL, id: \.self) { imageURL in
                AsyncImage(url: URL(string: urlPrefix + imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        ProgressView()
                            .foregroundStyle(.gray)
                    }
                }
                .background(.black)
            }
        }
        .tabViewStyle(.page)
        .frame(height: 250)
    }
}
