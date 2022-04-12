//
//  ContentView.swift
//  Shared
//
//  Created by Lin Yucheng on 2022/4/10.
//

import SwiftUI
import AVFoundation
import AVKit

struct SectionTimerView: View {
    @State var soundPlayer1: AVAudioPlayer!
    @State var soundPlayer2: AVAudioPlayer!
    let fonts: String = ""
    @State var minutes: Int = 10
    @State var seconds: Int = 00
    @State var TimerIsPaused: Bool = true
    @State private var timer: Timer? = nil
    
    let playerThread3 = DispatchQueue(label: "player3")
    let playerThread4 = DispatchQueue(label: "player4")
    
    func startTimer(){
        TimerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if minutes != 0 {
                if seconds == 0 {
                    seconds = 59
                    minutes -= 1
                } else {
                    seconds -= 1
                    if seconds == 0{
                        prompt1()
                    }
                }
            } else {
                if seconds == 0 {
                    minutes = 10
                } else {
                    seconds -= 1
                    prompt2()
                }
            }
        }
    }
    
    func stopTimer() {
        TimerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func restartTimer() {
        minutes = 10
        seconds = 0
    }
    
    func prompt1(){
        if minutes == 05 || minutes==03 || minutes==01 {
            playerThread3.async{
                soundPlayer1.play()
            }
        }
    }
    
    func prompt2() {
        if seconds <= 15 && seconds > 0 {
            playerThread3.async {
                soundPlayer1.play()
            }
        }
        else if seconds == 0 {
            playerThread4.async {
                soundPlayer2.play()
            }
        }
    }
    
    var body: some View {
        VStack{
            ZStack{
                Text("单节计时区")
                    .font(.largeTitle).fontWeight(.bold).bold()
                    .padding(40)
                    .frame(maxWidth: .infinity)
            }.onAppear {
                if let audioURL1 = Bundle.main.url(forResource: "sound1", withExtension: "mp3"){
                    soundPlayer1 = try! AVAudioPlayer(contentsOf: audioURL1)
                    soundPlayer1.prepareToPlay()
                }
                if let audioURL2 = Bundle.main.url(forResource: "sound2", withExtension: "mp3"){
                    soundPlayer2 = try! AVAudioPlayer(contentsOf: audioURL2)
                    soundPlayer2.prepareToPlay()
                }
            }
                    
            VStack{
                    Text("\(minutes):\(seconds)")
                        .font(.custom(fonts, fixedSize: 100))
                        //.frame(width: geo.size.width*0.8, height: geo.size.height*0.3)
                        .padding(60)
                        .shadow(color: Color(UIColor(white: 0, alpha: 0.4)), radius: 4, x: 0, y: 4)

                    if TimerIsPaused {
                        GeometryReader{ geo in
                            HStack {
                                Button(action:{
                                    configHaptic.impactOccurred()
                                    restartTimer()
                                }){
                                    VStack{
                                        Text("复位").font(.title).bold()
                                        Image(systemName: "backward.end.alt")
                                            .padding(.all).font(.title)
                                    }.foregroundColor(.white)
                                        .padding(50)
                                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.accentColor))
                                    .frame(width: geo.size.width*0.3, height: geo.size.height*0.3)
                                }.padding()
                                Button(action:{
                                    configHaptic.impactOccurred()
                                    startTimer()
                                }){
                                    VStack{
                                        Text("开始").font(.title).bold()
                                        Image(systemName: "play.fill")
                                            .padding(.all).font(.title)
                                    }.foregroundColor(.white)
                                        .padding(50)
                                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.accentColor))
                                    .frame(width: geo.size.width*0.8, height: geo.size.height*0.3)
                                }.padding()
                            }.frame(maxWidth: .infinity)
                                .padding()
                        }
                    } else {
                        GeometryReader{ geo in
                            Button(action:{
                                configHaptic.impactOccurred()
                                stopTimer()
                            }){
                                VStack{
                                    Text("暂停").font(.title).bold()
                                    Image(systemName: "stop.fill").font(.title)
                                        .padding(.all)}.frame(width: geo.size.width*0.8, height: geo.size.height*0.3)
                            }.foregroundColor(.white)
                                .padding()
                                .padding(.vertical)
                                .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.accentColor))
                            }
                        .padding(50)
                    }
            }
        }
    }
}


struct SectionTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTimerView()
    }
}
