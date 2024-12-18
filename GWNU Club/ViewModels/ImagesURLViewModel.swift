import SwiftUI

class ImagesURLViewModel: ObservableObject {
    @Published var imagesURL: [String] = []
    @Published var selectedImage: String = ""
    
    func fetchAllImages(url: String) async throws {
        guard let url = URL(string: url) else {
            throw CustomError.invalidURLError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw CustomError.invalidURLError
        }
        
        do {
            if let decoded = try? JSONDecoder().decode([String].self, from: data) {
                DispatchQueue.main.async {
                    self.imagesURL = decoded
                }
            }
        }
    }
}
