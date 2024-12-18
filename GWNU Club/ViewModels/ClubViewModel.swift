import SwiftUI

class ClubViewModel: ObservableObject {
    @Published var clubs: [Club] = []
    
//    func fetchClubs() {
//        guard let url = URL(string: APIConstants.clubListURL) else {
//            debugPrint("Error: Invalid URL")
//            return
//        }
//        
//        var request: URLRequest = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                debugPrint("Error: fetching data: \(error)")
//                return
//            }
//            
//            guard let data = data else {
//                debugPrint("Error: No data returned")
//                return
//            }
//            
//            do {
//                let clubs = try JSONDecoder().decode([Club].self, from: data)
//                DispatchQueue.main.async {
//                    self.clubs = clubs
//                    print("완료: ", clubs)
//                }
//            } catch {
//                debugPrint("Error decoding data: \(error)")
//            }
//        }.resume()
//    }
    
    func fetchClubs() async throws {
        guard let url = URL(string: APIConstants.clubListURL) else {
            throw CustomError.invalidURLError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw CustomError.invalidDataError
        }

        do {
            let clubs = try JSONDecoder().decode([Club].self, from: data)
            
            DispatchQueue.main.async { // 데이터 변경은 반드시 Main Thread에서 이뤄져야 한다
                self.clubs = clubs // 데이터 변경에 따라 화면의 새로고침이 이뤄지는 부분
            }
        } catch {
            debugPrint("Error decoding data: \(error)")
        }
    }
}
