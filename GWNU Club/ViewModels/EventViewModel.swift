import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    func fetchEvents() async throws {
        guard let url = URL(string: APIConstants.eventURL) else {
            throw CustomError.invalidURLError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw CustomError.invalidDataError
        }
        
        do {
            let events: [Event] = try JSONDecoder().decode([Event].self, from: data)
            
            DispatchQueue.main.async {
                self.events = events
            }
        } catch {
            throw error
        }
    }
}
