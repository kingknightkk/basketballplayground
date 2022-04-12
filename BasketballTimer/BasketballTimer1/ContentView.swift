//
//  ContentView.swift
//  basketballplayground
//
//  Created by 刘冠华 on 2022/4/10.
//

import SwiftUI
import AVFoundation
import AVKit
import Combine

//class musicshared: NSObject,ObservableObject{
//    @Published  var soundPlayer1: AVAudioPlayer!
//    @Published var soundPlayer2: AVAudioPlayer!
//    override init(){
//        if let audioURL1 = Bundle.main.url(forResource: "sound1", withExtension: "mp3"){
//            self.soundPlayer1 = try! AVAudioPlayer(contentsOf: audioURL1)
//            self.soundPlayer1.enableRate = true
//            self.soundPlayer1.prepareToPlay()
//        }
//        if let audioURL2 = Bundle.main.url(forResource: "sound2", withExtension: "mp3"){
//            self.soundPlayer2 = try! AVAudioPlayer(contentsOf: audioURL2)
//            self.soundPlayer2.enableRate = true
//            self.soundPlayer2.prepareToPlay()
//
//        }
//    }
//    
//}

struct ContentView: View {
  // 合并两个视图
    var body: some View {
                HStack {
                    SecondsTimerView()
                    SectionTimerView()
                }
 
                    
               
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
