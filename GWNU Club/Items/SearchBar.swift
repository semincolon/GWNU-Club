import SwiftUI

struct SearchBar: View {
    
    var hint: String
    @Binding var input: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.white)
                .frame(height: 50)
            
            HStack {
                TextField(hint, text: $input)
                    .focused($isFocused)
                    .keyboardType(.namePhonePad)
                    .autocorrectionDisabled()
                    .onSubmit {
                        isFocused = false
                        search()
                    }
                    .submitLabel(.search)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button(action: {
                                isFocused = false
                            }, label: {
                                Text("완료")
                            })
                        }
                    }
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
                        isFocused = false
                        search()
                    }
            }
            .padding(.horizontal, 16)
        }
        
    }
    
    func search() {
        input.removeAll()
        print("SEARCH: \(input)")
    }
}

//#Preview {
//    SearchBar()
//}
