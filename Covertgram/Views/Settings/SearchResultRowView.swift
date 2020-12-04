//
//  SearchResultRowView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 09/11/2020.
//

import SwiftUI

struct SearchResultRowView: View {
    
    let user: User
    
    var body: some View {
        HStack {
            if let url = user.profilePicture {
                ProfilePictureView(url: url)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(user.username)
                        .foregroundColor(user.private == true ? .red : .accentColor)
                        .fontWeight(.bold)
                    
                    if user.private == true {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.red)
                    }
                    
                    if user.verified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                    }
                }
                
                if user.fullName.count > 0 {
                    Text(user.fullName)
                        .font(.caption)
                }
            }
            
            Spacer()
        }.contentShape(Rectangle())
    }
}

#if DEBUG
struct SearchResultRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchResultRowView(user: MockData.Users.eefjah)
    }
}
#endif
