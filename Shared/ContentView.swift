//
//  ContentView.swift
//  Shared
//
//  Created by Yoshinobu Fujikake on 2/18/22.
//

import SwiftUI

struct ContentView: View {
    @State var iterationString = "0"
    
    @ObservedObject var kochFractal = KochFractal(withData: true)
    
    var body: some View {
        HStack {
            VStack {
                TextField("Iterations", text: $iterationString)
                    .padding()
                
                Button("It's fractal time, baby!", action: {Task.init{
                    
                    print("Start time \(Date())\n")
                    await self.calculateKoch()}})
                    .padding()
                    .frame(width: 200.0)
                    .disabled(kochFractal.enableButton == false)
            }
            
            FractalView(FractalVertices: $kochFractal.kochSnowflakeVertices)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            // Stop the window shrinking to zero.
            Spacer()
        }
    }
    
    func calculateKoch() async {
        kochFractal.kochSnowflakeVertices = []
        kochFractal.previousPoint = (0.0, 0.0)
        kochFractal.levelAngle = 0.0
        kochFractal.angleIsOffset = false
        kochFractal.maxLevel = Int(iterationString)!
        kochFractal.kochSides(level: Int(iterationString)!, sideLength: 200, startPoint: (xPoint: 0.0, yPoint: 0.0))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
