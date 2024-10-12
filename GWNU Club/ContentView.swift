//
//  ContentView.swift
//  GWNU Club
//
//  Created by 박세민 on 10/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            TabView {
                Tab("홈", systemImage: "house") {
                    Text("Home")
                }
                
                Tab("동아리", systemImage: "person.3.fill") {
                    Text("Club")
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
            }
        }
        
    }
}

#Preview {
    ContentView()
}

