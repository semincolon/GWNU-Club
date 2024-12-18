import SwiftUI

class DescriptionViewModel: ObservableObject {
    @Published var description: Description?
    
    func fetchDescription(url: String) async throws {
        guard let url = URL(string: url) else {
            throw CustomError.invalidURLError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw CustomError.invalidDataError
        }
        
        do {
            let description = try JSONDecoder().decode(Description.self, from: data)
        
            DispatchQueue.main.async {
                self.description = description
            }
        } catch {
            throw error
        }
    }
}
