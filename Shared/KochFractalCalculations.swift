//
//  KochFractalCalculations.swift
//  Koch Snowflake Fractal
//
//  Created by Yoshinobu Fujikake on 2/18/22.
//

import Foundation
import SwiftUI

///Takes edge length and the previous point to calculate the new point
func calculateKochPoints(edgeLength: Double, previousPoint: (xPoint: Double, yPoint: Double), angle: Double) -> (xPoint: Double, yPoint: Double) {
    var newPoint = (xPoint: 0.0, yPoint: 0.0)
    
    newPoint.xPoint = previousPoint.xPoint + cos(angle) * edgeLength
    newPoint.yPoint = previousPoint.yPoint + sin(angle) * edgeLength
    
    return newPoint
}
