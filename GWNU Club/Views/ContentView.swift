import SwiftUI

struct ContentView: View {
    
    @State var isLaunch: Bool = true
    @State var selectedTab: Int = 1
    
    var body: some View {
        
        if isLaunch {
            
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.linear) {
                            self.isLaunch = false
                        }
                    }
                }
            
        } else {
            
            VStack {
                
                TabView(selection: $selectedTab) {
//                    Tab("홈", systemImage: "house") {
//                        Text("Home")
//                    }
                    
                    Tab("동아리", systemImage: "person.3.fill", value: 1) {
                        ClubListView()
                    }
                    
                    Tab("행사", systemImage: "party.popper", value: 2) {
                        EventListView()
                    }
                    
//                    Tab("설정", systemImage: "gearshape") {
//                        Text("Set")
//                    }
                    
                }
                .tint(.primaryColor)
                .onAppear {
                    UITabBar.appearance().backgroundColor = .white
                    UITabBar.appearance().barTintColor = .white
                    UITabBar.appearance().unselectedItemTintColor = .lightGray
                }
                
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}

