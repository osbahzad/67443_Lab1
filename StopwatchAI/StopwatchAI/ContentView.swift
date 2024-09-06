//
//  ContentView.swift
//  StopwatchAI
//
//  Created by Omar Bahzad on 9/5/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI
import Combine

// StopwatchViewModel to handle the logic
class StopwatchViewModel: ObservableObject {
    @Published var timeElapsed: String = "00:00.00"
    private var timer: Timer?
    private var startTime: Date?
    private var elapsedTime: TimeInterval = 0.0
    
    func start() {
        if timer == nil {
            startTime = Date()
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                self.updateTime()
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        if let startTime = startTime {
            elapsedTime += Date().timeIntervalSince(startTime)
        }
    }
    
    func reset() {
        stop()
        elapsedTime = 0.0
        timeElapsed = "00:00.00"
    }
    
    private func updateTime() {
        if let startTime = startTime {
            let currentTime = Date().timeIntervalSince(startTime) + elapsedTime
            timeElapsed = formatTimeInterval(currentTime)
        }
    }
    
    private func formatTimeInterval(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        let fraction = Int((interval - Double(minutes * 60) - Double(seconds)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, fraction)
    }
}

// ContentView to define the UI
struct ContentView: View {
    @StateObject private var stopwatch = StopwatchViewModel()
    
    var body: some View {
        VStack {
            Text(stopwatch.timeElapsed)
                .font(.system(size: 60, weight: .bold, design: .monospaced))
                .padding()
            
            HStack {
                Button(action: {
                    stopwatch.start()
                }) {
                    Text("Start")
                        .font(.title)
                        .frame(width: 100, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    stopwatch.stop()
                }) {
                    Text("Stop")
                        .font(.title)
                        .frame(width: 100, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    stopwatch.reset()
                }) {
                    Text("Reset")
                        .font(.title)
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

// Preview for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

