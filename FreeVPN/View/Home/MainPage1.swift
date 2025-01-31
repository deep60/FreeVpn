//
//  MainPage1.swift
//  FreeVPN
//
//  Created by P Deepanshu on 31/01/25.
//

import SwiftUI

struct MainPage1: View {
    @State private var isConnected = false
    @State private var selectCountry = ""
    
    let id = UUID()
    let countries = ["Canada", "United Kingdom", "South Korea", "United States", "France", "Germany"]
    let countryFlags = ["🇨🇦", "🇬🇧", "🇰🇷", "🇺🇸", "🇫🇷", "🇩🇪"]
    
    var body: some View {
        ZStack {
            Color(red: 68 / 255, green: 66 / 255, blue: 82 / 255).opacity(0.7)
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Button {
                        print("Menu Bar")
                    } label: {
                        Image(systemName: "circle.grid.2x2")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 30, weight: .medium, design: .monospaced))
                    }
                    .padding()
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Premium")
                    }
                    .buttonStyle(PremiumButton())
                    .padding()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(Array(zip(countries, countryFlags)), id: \.1) { country, flag in
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 50, height: 50)
                                
                                Text(flag)
                                    .font(.system(size: 30))
                                
                                if selectCountry == country {
                                    Circle()
                                        .stroke(Color.blue, lineWidth: 3)
                                        .frame(width: 60, height: 60)
                                        .shadow(color: Color.blue.opacity(0.5), radius: 5)
                                }
                                
                            }
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectCountry = country
                                }
                             }
                        }
                    }
                    .padding()
                }
                
                Text(selectCountry)
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                
                Text(isConnected ? "Connected" : "Not Connected")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .padding()
                
                HStack {
                    Image(systemName: "globe")
                        .foregroundStyle(.white)
                    Text("Faster Server")
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
                
                Spacer()
                
                Button {
                    withAnimation {
                        isConnected.toggle()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(isConnected ? Color.green : Color.blue)
                            .frame(width: 120, height: 120)
                            .shadow(radius: 10)
                        
                        Image(systemName: "power")
                            .font(.system(size: 40))
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                
                Spacer() 
                
            }
        }
    }
}

struct PremiumButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 140, height: 35)
            .offset(x: 11)
            .padding(.vertical, 10)
            .background(Color(red: 92 / 255, green: 65 / 255, blue: 93 / 255))
            .foregroundStyle(Color.white)
            .font(.system(size: 18, weight: .bold, design: .rounded))
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

#Preview {
    MainPage1()
}
