//
//  AccountRowView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import SwiftUI

struct AccountRowView: View {
    
    let name: String
    
    @ObservedObject var presenter: SettingsPresenter
    
    @State var removeAccountAlertIsPresented = false
    
    var body: some View {
        Button(action: {
            self.removeAccountAlertIsPresented = true
        }, label: {
            HStack {
                Text(name)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }).alert(isPresented: $removeAccountAlertIsPresented, content: {
            Alert(title: Text("Stop Following"),
                  message: Text("Do you want to stop following \"\(name)\"?"),
                  primaryButton: .destructive(Text("Yes")) {
                    presenter.perform(.stopFollowing(username: name))
                  },
                  secondaryButton: .cancel())
        })
    }
}

#if DEBUG
struct AccountRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        AccountRowView(name: "Unnamed",
                       presenter: SettingsPresenter())
    }
}
#endif
