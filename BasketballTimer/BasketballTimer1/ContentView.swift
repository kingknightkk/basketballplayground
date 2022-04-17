//
//  ContentView.swift
//  basketballplayground
//
//  Created by 刘冠华 on 2022/4/10.
//

import SwiftUI

let configHaptic = UIImpactFeedbackGenerator(style: .light)
let promptAudio = AudioUtil(resourceName: "sound1")
let specialpromptAudio = AudioUtil(resourceName: "sound2")
struct ContentView: View {
    var body: some View {
        HStack {
            SecondsTimerView()
                .accentColor(.green)
            Divider()
            SectionTimerView()
                .accentColor(.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
