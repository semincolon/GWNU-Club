import SwiftUI

struct EventDetailView: View {
    var event: Event
    
    var body: some View {
        VStack {
            ZStack {
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(event.title)
                            .font(.blackHanSans48)
                            .foregroundStyle(.white)
                            .shadow(radius: 9, x: 0, y: 5)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .safeAreaPadding(.top, 80)
            .background(Rectangle().fill(Color.primaryColor))
            
            ScrollView {
                Text("이벤트 내용")
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    EventDetailView(event: Event(id: 1, title: "이벤트1", startDate: "2024-11-11", campus: .wonju, view: 0))
}
