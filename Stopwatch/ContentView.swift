//
//  ContentView.swift
//  Stopwatch
//
//  Created by Moinuddin Ahmad on 9/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isTimerRunning : Bool = false
    @State var count = 0.00
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
            
            // Main timer UI element
            
            Text("\(String(format: "%.1f", self.count))s")
                .font(.system(size: 60))
                .bold()
                .frame(width: 200, height: 200)
                .background(Circle().fill(Color.white).stroke(.black))
                .onReceive(self.timer) { time in
                    if isTimerRunning {
                        count += 0.1
                    }
                }
            
            HStack(spacing: 40) {
                
                // Play button interaction & logic
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .onTapGesture {
                        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                        isTimerRunning = true
                    }
                
                // Pause button interaction & logic
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .onTapGesture {
                        self.timer.upstream.connect().cancel()
                        isTimerRunning = false
                    }
                
                // Reset/Restart button interaction & logic
                Image(systemName: "restart.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                    .onTapGesture {
                        self.count = 0.00
                        isTimerRunning = false
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
