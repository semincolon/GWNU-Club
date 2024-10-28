//
//  ContentView.swift
//  GWNU Club
//
//  Created by 박세민 on 10/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLaunch: Bool = true
    
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
                
                TabView {
                    Tab("홈", systemImage: "house") {
                        VStack {
                            Text("Home")
                        }
                    }
                    
                    Tab("동아리", systemImage: "person.3.fill") {
                        ClubListView()
                    }
                    
                    Tab("이벤트", systemImage: "party.popper") {
                        Text("Event")
                    }
                    
                    Tab("설정", systemImage: "gearshape") {
                        Text("Set")
                    }
                    
                }
                .tint(.primaryColor)
                .onAppear {
                    UITabBar.appearance().backgroundColor = .white
                    UITabBar.appearance().unselectedItemTintColor = .lightGray
                }
                
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}

