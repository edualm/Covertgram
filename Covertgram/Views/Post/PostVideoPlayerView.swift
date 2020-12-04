//
//  PostVideoPlayerView.swift
//  Covertgram
//
//  Created by Eduardo Almeida on 07/11/2020.
//

import AVKit
import SwiftUI

struct PostVideoPlayerView: View {
    
    private let player: AVQueuePlayer
    private let looper: AVPlayerLooper
    
    init(url: URL) {
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        player = AVQueuePlayer(playerItem: item)
        player.isMuted = true
        
        looper = AVPlayerLooper(player: player, templateItem: item)
    }
    
    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                self.player.play()
            }
            .onDisappear {
                self.player.pause()
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.8)
    }
}

#if DEBUG
struct PostVideoPlayerView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostVideoPlayerView(url: MockData.URLs.video)
    }
}
#endif
