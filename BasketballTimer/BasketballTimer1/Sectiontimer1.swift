//
//  ContentView.swift
//  Shared
//
//  Created by Lin Yucheng on 2022/4/10.
//

import SwiftUI
import AVFoundation
import AVKit
//单节计时器
struct SectionTimerView: View {
    @State var soundPlayer1: AVAudioPlayer!
    @State var soundPlayer2: AVAudioPlayer!
    let fonts: String = ""
    //@State var hours: Int = 0
    @State var minutes: Int = 10
    @State var seconds: Int = 00
    @State var TimerIsPaused: Bool = true
    @State private var timer: Timer? = nil
    let playerThread3 = DispatchQueue(label: "player3")
    let playerThread4 = DispatchQueue(label: "player4")
    func startTimer(){
        TimerIsPaused = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
            if self.minutes != 00{
            if self.seconds == 00{
                
                self.seconds = 59
                self.minutes = self.minutes - 1
            }else {
                self.seconds = seconds - 1
                if self.seconds==00{
                    prompt1()                }
            }
            
            }else{
                
                if self.seconds==00{
                    
                    self.minutes = 10}
                else{ self.seconds = seconds - 1
                    prompt2()
                }
                
            
                    //self.hours = self.hours + 1
               
            }
    }
    }
    func stopTimer(){
        TimerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func restartTimer(){
        //hours = 0
        minutes = 10
        seconds = 0
    }
    func prompt1(){
        if minutes == 05 || minutes==03 || minutes==01{
            playerThread3.async{
                soundPlayer1.play()}
        }
            
        
    }
    func prompt2(){
        if self.seconds<=15 && self.seconds>0{
            playerThread3.async{
                soundPlayer1.play()}
        }
        else if self.seconds==0{
            playerThread4.async{
                soundPlayer2.play()}
        }
        
    }
    
    var body: some View {
        VStack{
            ZStack{
                GeometryReader{ geo in
                Text("单节计时区")
                    .font(.largeTitle).fontWeight(.bold).bold().padding().frame(width: screenWidth*0.5, height: screenheight*0.1,alignment:.center)}}
                        .onAppear{

                    if let audioURL1 = Bundle.main.url(forResource: "sound1", withExtension: "mp3"){
                        soundPlayer1 = try! AVAudioPlayer(contentsOf: audioURL1)
                        soundPlayer1.enableRate = true
                        soundPlayer1.prepareToPlay()
                    }
                    if let audioURL2 = Bundle.main.url(forResource: "sound2", withExtension: "mp3"){
                        soundPlayer2 = try! AVAudioPlayer(contentsOf: audioURL2)
                        soundPlayer2.enableRate = true
                        soundPlayer2.prepareToPlay()

                    }}
            VStack{
            GeometryReader{ geo in
                
                Text(//"\(hours):\(minutes):\(seconds)"
                    "\(minutes):\(seconds)"
                ).font(.custom(fonts,fixedSize: 100 ))
                .frame(width: geo.size.width*0.8, height: geo.size.height*0.3,alignment:.center).shadow(color: Color(UIColor(white: 0, alpha: 0.4)), radius: 4, x: 0, y: 4)}

                
                if TimerIsPaused{
                    GeometryReader{ geo in
                    HStack{
                        Button(action:{configHaptic.impactOccurred()
                            self.restartTimer()
                            
                            }){
                                VStack{
                                    Text("复位").font(.title).bold()
                                    
                                Image(systemName: "backward.end.alt")
                                        .padding(.all).font(.title)
                                }.frame(width: geo.size.width*0.3, height: geo.size.height*0.3, alignment: .center)
                               
                        }
                        .padding(.all)
                               
                        Button(action:{configHaptic.impactOccurred()
                            self.startTimer()
                            
                        }){
                            VStack{
                                Text("开始").font(.title).bold()
                                Image(systemName: "play.fill")
                                    .padding(.all).font(.title)
                            }.frame(width: geo.size.width*0.8, height: geo.size.height*0.3, alignment: .center)
                         
                        }
                        .padding(.all)
                    }}
                    
                } else {
                    GeometryReader{ geo in
                    Button(action:{configHaptic.impactOccurred()
                        self.stopTimer()
                        }){
                            VStack{
                                Text("暂停").font(.title).bold()
                                Image(systemName: "stop.fill").font(.title)
                                    .padding(.all)}.frame(width: geo.size.width*0.8, height: geo.size.height*0.3, alignment: .center)
                            
                            
                        }
                        .padding(.all)}
                }}
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

