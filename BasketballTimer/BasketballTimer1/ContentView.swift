//
//  ContentView.swift
//  basketballplayground
//
//  Created by 刘冠华 on 2022/4/10.
//

import SwiftUI

let configHaptic = UIImpactFeedbackGenerator(style: .light)

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
