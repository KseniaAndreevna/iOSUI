//
//  CloudShapeView.swift
//  VKApp
//
//  Created by Ksusha on 13.03.2021.
//

import SwiftUI

struct CloudShape: Shape {
        
    func path(in rect: CGRect) -> Path {

        var path = Path()
        path.move(to: CGPoint(x: rect.minX + 0.81028 * rect.width, y: rect.minY + 0.39009 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.77271 * rect.width, y: rect.minY + 0.39612 * rect.height), control1: CGPoint(x: rect.minX + 0.79766 * rect.width, y: rect.minY + 0.39009 * rect.height), control2: CGPoint(x: rect.minX + 0.78507 * rect.width, y: rect.minY + 0.39210 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.69093 * rect.width, y: rect.minY + 0.22300 * rect.height), control1: CGPoint(x: rect.minX + 0.76339 * rect.width, y: rect.minY + 0.32133 * rect.height), control2: CGPoint(x: rect.minX + 0.73325 * rect.width, y: rect.minY + 0.25753 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.55572 * rect.width, y: rect.minY + 0.21906 * rect.height), control1: CGPoint(x: rect.minX + 0.64862 * rect.width, y: rect.minY + 0.18847 * rect.height), control2: CGPoint(x: rect.minX + 0.59879 * rect.width, y: rect.minY + 0.18702 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.29076 * rect.width, y: rect.minY + 0.02004 * rect.height), control1: CGPoint(x: rect.minX + 0.51674 * rect.width, y: rect.minY + 0.04650 * rect.height), control2: CGPoint(x: rect.minX + 0.39812 * rect.width, y: rect.minY + -0.04260 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.16694 * rect.width, y: rect.minY + 0.44594 * rect.height), control1: CGPoint(x: rect.minX + 0.18340 * rect.width, y: rect.minY + 0.08269 * rect.height), control2: CGPoint(x: rect.minX + 0.12797 * rect.width, y: rect.minY + 0.27339 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.00002 * rect.width, y: rect.minY + 0.72706 * rect.height), control1: CGPoint(x: rect.minX + 0.07290 * rect.width, y: rect.minY + 0.45072 * rect.height), control2: CGPoint(x: rect.minX + -0.00139 * rect.width, y: rect.minY + 0.57584 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.17212 * rect.width, y: rect.minY + 1.00000 * rect.height), control1: CGPoint(x: rect.minX + 0.00143 * rect.width, y: rect.minY + 0.87829 * rect.height), control2: CGPoint(x: rect.minX + 0.07803 * rect.width, y: rect.minY + 0.99976 * rect.height))
        path.addLine(to: CGPoint(x: rect.minX + 0.81028 * rect.width, y: rect.minY + 1.00000 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 1.00000 * rect.width, y: rect.minY + 0.69504 * rect.height), control1: CGPoint(x: rect.minX + 0.91505 * rect.width, y: rect.minY + 1.00000 * rect.height), control2: CGPoint(x: rect.minX + 1.00000 * rect.width, y: rect.minY + 0.86347 * rect.height))
        path.addCurve(to: CGPoint(x: rect.minX + 0.81028 * rect.width, y: rect.minY + 0.39009 * rect.height), control1: CGPoint(x: rect.minX + 1.00000 * rect.width, y: rect.minY + 0.52662 * rect.height), control2: CGPoint(x: rect.minX + 0.91505 * rect.width, y: rect.minY + 0.39009 * rect.height))
        path.closeSubpath()
        return path
        
    }
    
}
