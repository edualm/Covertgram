//
//  SearchBar.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 09/11/2020.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
 
    @State private var isEditing = false
 
    var body: some View {
        TextField("Search for profile...", text: $text)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    if isEditing && text.count > 0 {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
            .onTapGesture {
                self.isEditing = true
            }
    }
}

#if DEBUG
struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
#endif
