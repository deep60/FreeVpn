//
//  MainPageView.swift
//  FreeVPN
//
//  Created by P Deepanshu on 28/01/25.
//

import SwiftUI

struct MainPageView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.1, blue: 0.5),
                    Color(red: 0.1, green: 0.05, blue: 0.3)
                ]), startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                HStack {
                    Button {
                        print("Menu Bar")
                    } label: {
                        Image(systemName: "circle.grid.2x2")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 30, weight: .medium, design: .monospaced))
                    }
                    
                    Spacer()
                    
                    Button {
                        print("premium features")
                    } label: {
                        Text("Premium")
                    }
                    .buttonStyle(PremiumButtonType())
                }
                .padding(.horizontal)
                
                TimeView()
                
                SpeedView()
                
                PowerButtonView()
            }
        }
    }
}

#Preview {
    MainPageView()
}

struct PremiumButtonType: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 140, height: 35)
            .offset(x: 10)
            .padding(.vertical, 10)
            .foregroundStyle(Color.white)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .background(
                LinearGradient(stops: [
                    .init(color: .purple, location: 0.0),
                    .init(color: .accentColor, location: 1.0)
                ], startPoint: .leading, endPoint: .trailing)
            )
            .overlay(
                Image(systemName: "crown.fill")
                    .foregroundStyle(.yellow)
                    .offset(x: -48)
            )
            .cornerRadius(25)
            .brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct TimeView: View {
    @State private var elapsedTime = 45 * 60 + 29
    var body: some View {
        VStack {
            Text("Connecting Time")
                .foregroundStyle(.white.opacity(0.8))
                .font(.headline)
            
            Text(timeString(from: elapsedTime))
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
        }
    }
    
    func timeString(from totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let min = (totalSeconds % 3600) / 60
        let sec = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, min, sec)
    }
}

struct SpeedView: View {
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "arrow.down.circle.fill")
                    .foregroundStyle(.red.opacity(1))
                Text("Download")
                    .foregroundStyle(.white.opacity(0.8))
                    .font(.caption)
                Text("348.3 Mbp/s")
                    .foregroundStyle(.white)
                    .font(.title3)
            }
            
            Divider()
                .frame(height: 50)
                .background(Color.white)
            
            VStack {
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundStyle(.green)
                Text("Upload")
                    .foregroundStyle(.white.opacity(0.8))
                    .font(.caption)
                Text("348.3 Mbp/s")
                    .foregroundStyle(.white)
                    .font(.title3)
            }
        }
        .padding(.horizontal, 30)
        
        HStack {
            Image(systemName: "flag.fill")
                .foregroundStyle(.white)
                .font(.title)
            
            VStack(alignment: .leading) {
                Text("United Kingdom")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                Text("212.369.56.87")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.caption)
            }
        }
        .padding()
        .background(Color.purple.opacity(0.8))
        .cornerRadius(20)
        .padding(.horizontal)
        
        Spacer()
    }
}

struct GlowingRingShow: View {
    var body: some View {
        ZStack {
            ForEach(0..<3) { i in
                Circle()
                    .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                    .frame(width: 280 + CGFloat(i * 40), height: 280 + CGFloat(i * 40))
            }
        }
    }
}

struct MainPowerButton: View {
    @Binding var isPressed: Bool
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isPressed.toggle()
            }
            // Add haptic feedback
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.impactOccurred()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.5) , lineWidth: 8)
                    )
                    .shadow(color: Color.blue.opacity(0.5) , radius: 20, x: 0, y: 0)
                
                Image(systemName: "power")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 260, height: 260)
        .scaleEffect(isPressed ? 0.95 : 1.0)
    }
}

struct PowerButtonView: View {
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            WorldMapShape()
                .fill(Color.white.opacity(0.1))
                .padding()
            
            GlowingRingShow()
            
            MainPowerButton(isPressed: $isPressed)
        }
    }
}


//struct PowerSymbol: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        
//        let center = CGPoint(x: rect.midX, y: rect.midY)
//        let radius = min(rect.width, rect.height) / 2
//        
//        // Vertical Lines
//        path.move(to: CGPoint(x: center.x, y: center.y - radius * 0.5))
//        path.addLine(to: CGPoint(x: center.x, y: center.y + radius * 0.2))
//        
//        // Circle
//        path.addArc(center: center, radius: radius * 0.7, startAngle: .degrees(-60), endAngle: .degrees(240), clockwise: false)
//        
//        return path
//    }
//}

struct WorldMapShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: CGRect(x: rect.width * 0.2, y: rect.height * 0.3, width: rect.width * 0.2, height: rect.height * 0.2), cornerSize: CGSize(width: 20, height: 20))
        
        return path
    }
}
