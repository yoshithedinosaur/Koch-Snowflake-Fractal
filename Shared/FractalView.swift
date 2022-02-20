//
//  FractalView.swift
//  Koch Snowflake Fractal
//
//  Created by Yoshinobu Fujikake on 2/18/22.
//

import Foundation
import SwiftUI

struct FractalView: View {
    
    @Binding var FractalVertices : [(xPoint: Double, yPoint: Double)]

    var body: some View {
        
        //Create the displayed View
        FractalShape(FractalPoints: FractalVertices)
            .stroke(Color.red, lineWidth: 1)
            .frame(width: 600, height: 600)
            .background(Color.white)

    }
    
    

/// FractalShape
///
/// calculates the Shape displayed in the Cesaro Fractal View
///
/// - Parameters:
///   - FractalPoints: array of tuples containing the Cesaro Fractal Vertices
///
struct FractalShape: Shape {
    
    var FractalPoints: [(xPoint: Double, yPoint: Double)] = []  ///Array of tuples
    
    
    /// path
    ///
    /// - Parameter rect: rect in which to draw the path
    /// - Returns: path for the Shape
    ///
    func path(in rect: CGRect) -> Path {
        

        // Create the Path for the Fractal
        
        
        
        var path = Path()
        
        if FractalPoints.isEmpty {
            
            return path
        }

        // move to the initial position
        path.move(to: CGPoint(x: FractalPoints[0].xPoint, y: -FractalPoints[0].yPoint+300))

        // loop over all our points to draw create the paths
        for item in 1..<(FractalPoints.endIndex)  {
        
            path.addLine(to: CGPoint(x: FractalPoints[item].xPoint, y: -FractalPoints[item].yPoint+300))
            
            
            }


        return (path)
        }
    }


}


struct FractalView_Previews: PreviewProvider {
    
    @State static var myFractalVertices = [(xPoint:75.0, yPoint:25.0), (xPoint:32.0, yPoint:22.0), (xPoint:210.0, yPoint:78.0), (xPoint:75.0, yPoint:25.0)]
    
    static var previews: some View {
    

        FractalView(FractalVertices: $myFractalVertices)
        
    }
}


