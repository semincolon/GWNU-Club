import SwiftUI

struct EventListView: View {
    @State private var searchEvent: String = ""
    @State private var selectedCampus: Campus = Campus.all
    @State private var events: [Event] = []
    
    @StateObject private var eventViewModel: EventViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("행사")
                            .font(.blackHanSans48)
                            .foregroundStyle(.white)
                            .shadow(radius: 9, x: 0, y: 5)
                        
                        SearchBar(hint: "행사 검색", input: $searchEvent)
                    }
                    
                    // 캠퍼스 선택 Picker
                    Picker("Campus", selection: $selectedCampus) {
                        Text("전체").tag(Campus.all)
                        Text("강릉캠퍼스").tag(Campus.gangneung)
                        Text("원주캠퍼스").tag(Campus.wonju)
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
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(events, id: \.id) { event in
                                NavigationLink(destination: EventDetailView(event: event)) {
                                    EventItem(event: event)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        .id("TOP")
                    }
                    .onChange(of: selectedCampus) {
                        proxy.scrollTo("TOP", anchor: .top)
                        self.events = selectedCampus == Campus.all ? eventViewModel.events : eventViewModel.events.filter { $0.campus == selectedCampus }
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            .onTapGesture {
                hideKeyboard()
            }
        }
        .tint(.white)
        .onAppear {
            Task {
                try await eventViewModel.fetchEvents()
                self.events = eventViewModel.events
            }
        }
    }
}

struct EventItem: View {
    var event: Event
    
    var body: some View {
        VStack {
            ThumbnailImage(thumbnailURL: APIConstants.imageURL + "/events/\(event.id)/\(event.thumbnailImage)")
            
            VStack {
                Text(event.title)
                    .multilineTextAlignment(.center)
            
                HStack {
                    Text(event.startDate)
                        .font(.caption)
                    
                    Text("조회수 | \(event.view)")
                        .font(.caption2)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .border(.gray, width: 2)
    }
}

//#Preview {
//    EventListView()
//}
