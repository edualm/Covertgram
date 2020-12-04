//
//  WatchSyncStateView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 17/11/2020.
//

import SwiftUI

struct WatchSyncStateView: View {
    
    let state: SettingsPresenter.ViewModel.WatchSyncState
    
    var body: some View {
        switch state {
        case .failure(let error):
            Text("An error has occurred. \(error.localizedDescription)")
                .foregroundColor(.red)
                .font(.caption)
            
        case .success:
            Text("Synced successfully!")
                .foregroundColor(.green)
                .font(.caption)
            
        case .working:
            Text("Attempting to sync...")
                .font(.caption)
            
        case .unknown:
            EmptyView()
        }
    }
}

#if DEBUG
struct WatchSyncStateView_Previews: PreviewProvider {
    
    static var previews: some View {
        WatchSyncStateView(state: .success)
    }
}
#endif
