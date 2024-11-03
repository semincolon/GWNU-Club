import SwiftUI

struct EventListView: View {
    
    private var gridItems: [GridItem] = [GridItem()]
    private var events: [Event] = [
        .init(id: 1, title: "이벤트1", startDate: "2024-11-11", campus: .wonju, view: 0),
        .init(id: 2, title: "이벤트2", startDate: "2024-11-12", campus: .wonju, view: 0),
        .init(id: 3, title: "이벤트3", startDate: "2024-11-13", campus: .wonju, view: 0),
        .init(id: 4, title: "이벤트4", startDate: "2024-11-14", campus: .wonju, view: 0),
        .init(id: 5, title: "이벤트5", startDate: "2024-11-15", campus: .wonju, view: 0),
        .init(id: 6, title: "이벤트6", startDate: "2024-11-16", campus: .wonju, view: 0),
        .init(id: 7, title: "이벤트7", startDate: "2024-11-17", campus: .wonju, view: 0),
        .init(id: 8, title: "이벤트8", startDate: "2024-11-18", campus: .wonju, view: 0),
        .init(id: 9, title: "이벤트9", startDate: "2024-11-19", campus: .wonju, view: 0),
        .init(id: 10, title: "이벤트10", startDate: "2024-11-20", campus: .wonju, view: 0)
    ]
    
    @State private var searchEvent: String = ""
    @State private var selectedCampus: Campus = Campus.all
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("이벤트")
                            .font(.blackHanSans48)
                            .foregroundStyle(.white)
                            .shadow(radius: 9, x: 0, y: 5)
                        
                        SearchBar(hint: "이벤트 검색", input: $searchEvent)
                    }
                    
                    // 캠퍼스 선택 Picker
                    Picker("Campus", selection: $selectedCampus) {
                        ForEach(Campus.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .background(RoundedRectangle(cornerRadius: 7).foregroundStyle(Color(white: 1, opacity: 0.2)))
                    .frame(width: 300)
                    .padding(.top, 10)
                }
                .padding()
                .safeAreaPadding(.top, 45)
                .background(Rectangle().fill(Color.primaryColor))
                
                // 이벤트 목록
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(events) { event in
                            EventItem(event: event)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .ignoresSafeArea(edges: .top)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .tint(.white)
    }
}

struct EventItem: View {
    var event: Event
    
    var body: some View {
        VStack {
            Image(systemName: "widget.medium")
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            
            VStack {
                Text(event.title)
            
                HStack {
                    Text(event.startDate)
                        .font(.caption)
                    
                    Text("조회수 | \(event.view)")
                        .font(.caption2)
                }
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    EventListView()
}
