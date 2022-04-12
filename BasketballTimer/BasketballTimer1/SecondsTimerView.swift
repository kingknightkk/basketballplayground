//
//  ContentView.swift
//  basketballplayground
//
//  Created by 刘冠华 on 2022/4/5.
//

import SwiftUI
import AVFoundation
import AVKit

//24秒计时器
let screenWidth=UIScreen.main.bounds.width
let screenheight=UIScreen.main.bounds.height
let configHaptic = UIImpactFeedbackGenerator(style: .light)
struct SecondsTimerView: View {
    @State private var timer = Timer.publish(every: 1, tolerance: 0.05, on: .main, in: .common).autoconnect()
    @State private var count = true
    @State public var soundPlayer1: AVAudioPlayer!
    @State public var soundPlayer2: AVAudioPlayer!
    let fonts: String = ""
    let playerThread1 = DispatchQueue(label: "player1")
    let playerThread2 = DispatchQueue(label: "player2")
    @State var timeRemaining = 0
    func rebuildtime(){
        self.timer=Timer.publish(every: 1, tolerance: 0.05, on: .main, in: .common).autoconnect()}
    //
    func timestart(){
        
        timeRemaining = 24
        count=true
        rebuildtime()
        
        }
    
    func reset(){
        timeRemaining = 14
        count = true
        rebuildtime()

        
    }
    var body: some View {
        VStack{
            
            ZStack{
                GeometryReader{ geo in
                Text("24秒计时区")
                    .font(.largeTitle).fontWeight(.bold).bold().padding().frame(width: screenWidth*0.5, height: screenheight*0.1,alignment:.center)}.onAppear{
                      
                    if let audioURL1 = Bundle.main.url(forResource: "sound1", withExtension: "mp3"){
                        soundPlayer1 = try! AVAudioPlayer(contentsOf: audioURL1)
                        soundPlayer1.enableRate = true
                        soundPlayer1.prepareToPlay()
                    }
                    if let audioURL2 = Bundle.main.url(forResource: "sound2", withExtension: "mp3"){
                        soundPlayer2 = try! AVAudioPlayer(contentsOf: audioURL2)
                        soundPlayer2.enableRate = true
                        soundPlayer2.prepareToPlay()
                        
                    }}}
                    
            GeometryReader{ geo in
                VStack(alignment:.center){
                
                Text("\(timeRemaining)秒").font(.custom(fonts,fixedSize: 100 )).foregroundColor(count ? .green : .red)

                    .frame(width: geo.size.width*0.8, height: geo.size.height*0.3,alignment:.center).shadow(color: Color(UIColor(white: 0, alpha: 0.4)), radius: 4, x: 0, y: 4)

                .onReceive(timer){ _ in
               
                     if self.timeRemaining>0{
                         self.timeRemaining-=1
                        if self.timeRemaining<=10 && self.timeRemaining>0{
                            if self.timeRemaining==10{
                                count = false
                                //soundPlayer1.currentTime = 0
                                playerThread1.async{
                                    soundPlayer1.play()}
                            }else{
                               // soundPlayer1.currentTime = 0
                                playerThread1.async{
                                    soundPlayer1.play()}
                           
                            
                                }}
                        else if self.timeRemaining==0{
                            //soundPlayer2.currentTime = 0
                            playerThread2.async{
                                soundPlayer2.play()}
                         }}
                         
                     
                 }
                    
                
                
                Button{configHaptic.impactOccurred()
                    timestart()
                } label:{ RoundedRectangle(cornerRadius:
                                            20).fill(Color.blue).frame(width: geo.size.width*0.8, height: geo.size.height*0.2,alignment:.center).overlay(Text("开始计时").font(.title).foregroundColor(Color.white).bold())
                }
                Button{configHaptic.impactOccurred()
                    reset()
                } label:{RoundedRectangle(cornerRadius:
                                            20).fill(Color.blue).frame(width: geo.size.width*0.8, height: geo.size.height*0.2,alignment:.center).overlay (Text("复位").font(.title).foregroundColor(Color.white).bold())
                    
                    
                    
                }}}
        }
    }}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SecondsTimerView()
//    }
//}
