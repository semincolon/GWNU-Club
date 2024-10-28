//
//  Untitled.swift
//  GWNU Club
//
//  Created by 박세민 on 10/25/24.
//

import SwiftUI

enum Campus: String, CaseIterable, Identifiable {
    case gangneung = "강릉캠퍼스"
    case wonju = "원주캠퍼스"
    var id: Self { self }
}

enum ClubType: String, CaseIterable, Identifiable {
    case all = "전체"
    case religion = "종교"
    case exercise = "운동"
    case show = "공연"
    case other = "기타"
    var id: Self { self }
}

struct ClubListView: View {
    
    @State private var searchClub: String = ""
    @State private var selectedCampus: Campus = Campus.gangneung
    @State private var selectedType: ClubType = ClubType.all
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .top) {
                
                Rectangle()
                    .fill(Color.primaryColor)
                    .frame(height: 285)
                
                VStack {
                    
                    VStack(alignment: .leading) {
                        Text("동아리")
                            .font(.blackHanSans48)
                            .foregroundStyle(.white)
                            .shadow(radius: 9, x: 0, y: 5)
                        
                        SearchBar(searchClub: $searchClub)
                    }
                     
                    VStack {
                        
                        Picker("Campus", selection: $selectedCampus) {
                            ForEach(Campus.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .background(RoundedRectangle(cornerRadius: 7)
                            .foregroundStyle(Color(white: 1, opacity: 0.2)))
                        .frame(width: 250)
                        .padding(.bottom, 10)
                        
                        
                        Picker("Type", selection: $selectedType) {
                            ForEach(ClubType.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .background(RoundedRectangle(cornerRadius: 7)
                            .foregroundStyle(Color(white: 1, opacity: 0.2)))
                        
                    }
                    .padding(.vertical, 10)
                    
                }
                .padding()
                .safeAreaPadding(.top, 45)
                
            }
            
            ScrollView {
                Text("동아리 목록 여기에")
            }
            
        }
        .ignoresSafeArea(edges: .top)
    }

}

struct SearchBar: View {
    
    @Binding var searchClub: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.white)
                .frame(height: 50)
            
            HStack {
                TextField("동아리명으로 검색", text: $searchClub)
                    .padding(.trailing, 3)
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .background(Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.primaryColor))
                    .onTapGesture {
                        print("Enter : \(searchClub)")
                        searchClub.removeAll()
                    }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ClubListView()
}
