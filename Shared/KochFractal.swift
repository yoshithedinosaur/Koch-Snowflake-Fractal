//
//  KochFractal.swift
//  Koch Snowflake Fractal
//
//  Created by Yoshinobu Fujikake on 2/18/22.
//

import Foundation
import CoreText

class KochFractal: NSObject, ObservableObject {
    
    @MainActor @Published var kochSnowflakeVertices = [(xPoint: Double, yPoint: Double)]()
    
    @Published var enableButton = true
    
    @MainActor init(withData data: Bool){
        
        super.init()
        
        kochSnowflakeVertices = []

        
    }
    
    ///Pseudo code:
    ///Pick starting point(s) (just calculate one side for 'n' iterations, then duplicate and rotate sides)
    ///How to calculate Koch snowflake:
    /// -Take a line
    /// -Cut it into thirds (four points)
    /// -"Rotate" middle segment by 60 degrees, (ie, raise middle point by cos(60) )
    /// -Do that recursively

    var sideLength: Double = 600
    var previousPoint: (xPoint: Double, yPoint: Double) = (0.0, 0.0)
    //var levelAngle: Double = 0.0
    var fractalVerts = [(xPoint: Double, yPoint: Double)]()
    var maxLevel: Int = 0
    var atBPoint: Bool = false
    var angleIsOffset: Bool = false
        
    ///        C
    ///        /\
    ///       /    \
    ///A____B/        \D_____E
    ///
    @MainActor func kochSides(level: Int, sideLength: Double, startPoint: (xPoint: Double, yPoint: Double), levelAngle: Double) {
        
        let fractalAngle: Double = Double.pi/3
        
        
        
        if(level == 0) {
            print("END")
            //updateKoch(newVerts: fractalVerts[fractalVerts.endIndex-1])
        } else {
            
            //if atBPoint {
            //    levelAngle -= 4*fractalAngle
            //    angleIsOffset = true
            //}
            
            //Point A
            fractalVerts = [previousPoint]
            kochSides(level: level-1, sideLength: sideLength/3, startPoint: fractalVerts[fractalVerts.endIndex-1], levelAngle: levelAngle)
            //atBPoint = false
            
            //Point B
            fractalVerts.append((previousPoint.xPoint + sideLength * cos(levelAngle), previousPoint.yPoint + sideLength * sin(levelAngle)))
            kochSides(level: level-1, sideLength: sideLength/3, startPoint: fractalVerts[fractalVerts.endIndex-1], levelAngle: levelAngle+fractalAngle)
            //levelAngle += fractalAngle
            //atBPoint = true

            //Point C
            fractalVerts.append(calculateKochPoints(edgeLength: sideLength, previousPoint: fractalVerts[fractalVerts.endIndex-1], angle: levelAngle))
            kochSides(level: level-1, sideLength: sideLength/3, startPoint: fractalVerts[fractalVerts.endIndex-1], levelAngle: levelAngle-fractalAngle)
            //levelAngle -= 2*fractalAngle
            //atBPoint = false
            
            //Point D
            fractalVerts.append(calculateKochPoints(edgeLength: sideLength, previousPoint: fractalVerts[fractalVerts.endIndex-1], angle: levelAngle))
            kochSides(level: level-1, sideLength: sideLength/3, startPoint: fractalVerts[fractalVerts.endIndex-1], levelAngle: levelAngle)
            //levelAngle += fractalAngle
            //atBPoint = false

            //Point E
            //if (level == 1) {
            //    fractalVerts.append(calculateKochPoints(edgeLength: sideLength, previousPoint: fractalVerts[fractalVerts.endIndex-1], angle: levelAngle))
            //    kochSides(level: level-1, sideLength: sideLength/3, startPoint: fractalVerts[fractalVerts.endIndex-1], levelAngle: levelAngle)
                //atBPoint = false
                
            //}
            if level == maxLevel {print("FINAL POINT")}
            
            //if angleIsOffset {
            //    levelAngle += 3*fractalAngle
            //    angleIsOffset = false
            //} else {
            //    levelAngle += fractalAngle
            //}
            
        }
        
        previousPoint = fractalVerts[fractalVerts.endIndex-1]
        //if (level < maxLevel){
            updateKoch(newVerts: fractalVerts[fractalVerts.endIndex-1])
            print("\(fractalVerts)")
            
        //}
        
    }
    
//    func turn (oldAngle: Double, angleChange: Double) -> Double {
//        let newAngle = oldAngle + angleChange
//        return newAngle
//    }
    
    @MainActor func updateKoch (newVerts: (xPoint: Double, yPoint: Double)) {
        kochSnowflakeVertices.append(newVerts)
    }
    
}
