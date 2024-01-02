//
//  CircularLoaderView.swift
//  swiftData1229
//
//  Created by imac-2627 on 2023/12/29.
//

import SwiftUI

struct CircularLoaderView: View {
    @State private var animate = false
    
    let gradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .primary, location: 0.1),
            Gradient.Stop(color: .primary.opacity(0.8), location: 0.4),
            Gradient.Stop(color: .primary.opacity(0.4), location: 0.8)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        Circle()
            .stroke(gradient, lineWidth: 8)
            .frame(width: 80, height: 80)
            .rotationEffect(Angle(degrees: animate ? 360 : 0))
            .animation(
                .linear(duration: 1)
                .repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear {
                withAnimation {
                    animate.toggle()
                }
            }
    }
}

struct RotateImageLoaderView: View {
    @State private var animate = false
    var body: some View {
        Image(systemName: "gear")
            .resizable()
            .frame(width: 100, height: 100)
            .rotationEffect(Angle(degrees: animate ? 370 : 0))
            .animation(
                .linear(duration: 1)
                .repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear {
                withAnimation {
                    animate.toggle()
                }
            }
    }
}

struct RotateCircleAroundCircle: View {
    @State private var angle: Double = 0
    var timeInterval: TimeInterval = 0.1
    var size: CGFloat = 80
    
    var body: some View {
        VStack {
            Circle()
                .stroke(.black, lineWidth: 2)
                .frame(width: size, height: size)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 10, height: 10)
                        .offset(
                            x: size/2 * CGFloat(cos(angle)),
                            y: size/2 * CGFloat(sin(angle))
                        )
                )
        }
        .onAppear {
            let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
                withAnimation {
                    angle += 0.1
                }
            }
            RunLoop.current.add(timer, forMode: .common)
        }
    }
}

struct MultiCircleLoaderView: View {
    var body: some View {
        ZStack {
            RotateCircleAroundCircle(timeInterval: 0.03, size: 120)
            RotateCircleAroundCircle(timeInterval: 0.05, size: 90)
            RotateCircleAroundCircle(timeInterval: 0.07, size: 60)
        }
    }
}

struct SquareLoaderView: View {
    @State private var xOffset: CGFloat = 40
    @State private var yOffset: CGFloat = -40
    var size: CGFloat = 80
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(.black, lineWidth: 2)
                .frame(width: size, height: size)
            
            Circle()
                .fill(.black)
                .frame(width: 10, height: 10)
                .offset(x: xOffset, y: yOffset)
                .onAppear {
                    let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                        withAnimation {
                            if yOffset == -size/2 && xOffset != -size/2 {
                                self.xOffset += -1
                            } else if xOffset == -size/2 && yOffset != size/2 {
                                self.yOffset += 1
                            } else if yOffset == size/2 && xOffset != size/2 {
                                self.xOffset += +1
                            } else if xOffset == size/2 && yOffset != -size/2 {
                                self.yOffset += -1
                            }
                        }
                    }
                    RunLoop.current.add(timer, forMode: .common)
                }
        }
    }
}

struct AnimatedStrokeRectangle: View {
    @State private var trimEnd: CGFloat = 0.0
    
    var body: some View {
        Rectangle()
            .trim(from: 0.0, to: trimEnd)
            .stroke(.black, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            .frame(width: 80, height: 80)
            .animation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true)
                , value: trimEnd
            )
            .onAppear {
                self.trimEnd = 1.0
            }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct AnimatedStrokeTriangle: View {
    @State private var trimEnd: CGFloat = 0.0
    
    var body: some View {
        Triangle()
            .trim(from: 0.0, to: trimEnd)
            .stroke(.black, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            .frame(width: 80, height: 80)
            .animation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true)
                , value: trimEnd
            )
            .onAppear {
                self.trimEnd = 1.0
            }
    }
}


struct CircleFillLoaderView: View {
    
    @State private var trimEnd: CGFloat = 0.0
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: trimEnd)
            .frame(width: 80, height: 80)
            .animation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true)
                , value: trimEnd
            )
            .onAppear {
                trimEnd = 1
            }
    }
}

struct CirclesLoaderView: View {
    @State private var degree = 270
    var count: Int = 13
    
    var body: some View {
        GeometryReader { bounds in
            ForEach(0..<count, id: \.self) { i in
                Circle()
                    .fill(.black)
                    .frame(width: getDotSize(i), height: getDotSize(i), alignment: .center)
                    .offset(x: (bounds.size.width / 2) - 12)
                    .rotationEffect(.degrees(.pi * 2 * Double(i * 5)))
            }
            .frame(width: bounds.size.width, height: bounds.size.height, alignment: .center)
            .rotationEffect(.degrees(Double(degree)))
            .animation(
                Animation.linear(duration: 1.5)
                    .repeatForever(autoreverses: false),
                value: degree
            )
            .onAppear{
                degree = 270 + 360
            }
        }
        .frame(width: 90, height: 90)
    }
    
    private func getDotSize(_ index: Int) -> CGFloat {
        CGFloat(index)
    }
}

struct ModernCircularLoader: View {
    @State private var trimEnd = 0.6
    @State private var animate = false
    
    var body: some View {
        Circle()
            .trim(from: 0.0,to: trimEnd)
            .stroke(.black, style: StrokeStyle(lineWidth: 7,lineCap: .round,lineJoin:.round))
            .animation(
                Animation.easeIn(duration: 1.5)
                    .repeatForever(autoreverses: true),
                value: trimEnd
            )
            .frame(width: 70,height: 70)
            .rotationEffect(Angle(degrees: animate ? 270 + 360 : 270))
            .animation(
                Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear{
                animate = true
                trimEnd = 0
            }
    }
}

struct DashCircleLoaderView: View {
    @State private var trimEnd = 0.6
    @State private var degree = 270
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .butt, miterLimit: 0, dash: [10, 3], dashPhase: 0))
                .foregroundColor(.black.opacity(0.2))
            
            Circle()
                .trim(from: 0.0, to: trimEnd)
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .butt, miterLimit: 0, dash: [10, 3], dashPhase: 0))
                .animation(
                    Animation.easeIn(duration: 1.5)
                        .repeatForever(autoreverses: true),
                    value: trimEnd
                )
                .rotationEffect(Angle(degrees: Double(degree)))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: degree
                )
                .onAppear{
                    degree = 270 + 360
                    trimEnd = 0
                }
        }
        .frame(width: 70,height: 70)
    }
}

struct BottomToTopFill: View {
    @State var offset: CGFloat = 80
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.clear)
                .frame(width: 80, height: 80)
                .overlay {
                    Circle()
                        .stroke(.black)
                }
            
            Rectangle()
                .fill(.black)
                .frame(width: 80, height: 80)
                .offset(y: offset)
        }
        .clipShape(.circle)
        .animation(
            Animation.linear(duration: 3)
                .repeatForever(autoreverses: true),
            value: offset
        )
        .onAppear {
            offset = 0
        }
    }
}

struct PieSegment: Shape {
    var start: Angle
    var end: Angle
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: center)
        path.addArc(center: center, radius: rect.midX, startAngle: start, endAngle: end, clockwise: false)
        return path
    }
}

struct PieSegmentLoader: View {
    
    @State var degree: Double = 10
    @State var isFurther = true
    
    var body: some View {
        PieSegment(start: .zero, end: .degrees(degree))
            .frame(width: 80, height: 80)
            .animation(
                Animation.linear(duration: 3)
                    .repeatForever(autoreverses: false),
                value: degree
            )
            .onAppear {
                let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    withAnimation {
                        if isFurther {
                            if degree <= 360 {
                                degree += 1
                            }
                            if degree == 360 {
                                isFurther = false
                            }
                        } else {
                            if degree > 0 {
                                degree -= 1
                            }
                            if degree == 0 {
                                isFurther = true
                            }
                        }
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            }
    }
}

struct anyLoaderView: View {
    var body: some View {
        VStack(spacing:0) {
            
            HStack(spacing:0) {
                
                CircularLoaderView()
                    .padding()
                RotateImageLoaderView()
                    .padding()
                MultiCircleLoaderView()
            }
            HStack(spacing:0) {
                SquareLoaderView()
                    .padding()
                AnimatedStrokeRectangle()
                    .padding()
                AnimatedStrokeTriangle()
            }
            HStack(spacing:0) {
                CircleFillLoaderView()
                    .padding()
                CirclesLoaderView()
                    .padding()
                ModernCircularLoader()
            }
            HStack(spacing:0) {
                DashCircleLoaderView()
                    .padding()
                BottomToTopFill()
                    .padding()
                PieSegmentLoader()
            }
            
        }
    }
}

#Preview("Circul") {
    anyLoaderView()
}
