//
//  SignUpView.swift
//  FreeVPN
//
//  Created by P Deepanshu on 24/01/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @State private var selectedTab = 1
    @Namespace var name
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 28) {
                // Header Section
                VStack(spacing: 8) {
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("The VPN App is for free 1 month trial. Make sure you use accurate information.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                }
                .padding(.top, 40)
                
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedTab = 0
                        }
                    }) {
                        VStack {
                            Text("Log In")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedTab == 0 ? .white : .gray)
                            
                            ZStack {
                                Capsule()
                                    .fill(Color.black.opacity(0.4))
                                    .frame(height: 4)
                                
                                if selectedTab == 0 {
                                    Capsule()
                                        .fill(Color.purple)
                                        .frame(height: 4)
                                        .matchedGeometryEffect(id: "Tab", in: name)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedTab = 1
                        }
                    }) {
                        VStack {
                            Text("Sign Up")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(selectedTab == 1 ? .white : .gray)
                            
                            ZStack {
                                Capsule()
                                    .fill(Color.black.opacity(0.4))
                                    .frame(height: 4)
                                
                                if selectedTab == 1 {
                                    Capsule()
                                        .fill(Color.purple)
                                        .frame(height: 4)
                                        .matchedGeometryEffect(id: "Tab", in: name)
                                }
                            }
                        }
                    }
                }
                
                // Social Buttons
                VStack(spacing: 16) {
                    Button(action: {
                        print("Sign up with Google tapped")
                    }) {
                        HStack {
                            Image("glogo") // Placeholder for Google logo
                                .resizable()
                                .frame(width: 34, height: 34)
                                .foregroundColor(.red)
                            Text("Sign up with Google")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    
                    Button(action: {
                        print("Sign up with Apple tapped")
                    }) {
                        HStack {
                            Image(systemName: "applelogo") // Placeholder for Apple logo
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray)
                            Text("Sign up with Apple")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                }
                
                // Divider
                HStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                    Text("Or better yet...")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                }
                .padding(.horizontal)
                
                // Form Fields
                VStack(spacing: 16) {
                    // Email Field
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email Address", text: $email)
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purple, lineWidth: 1)
                    )
                    
                    // Password Field
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .foregroundColor(.white)
                        } else {
                            SecureField("Password", text: $password)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                    // Confirm Password Field
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        if isConfirmPasswordVisible {
                            TextField("Confirm Password", text: $confirmPassword)
                                .foregroundColor(.white)
                        } else {
                            SecureField("Confirm Password", text: $confirmPassword)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            isConfirmPasswordVisible.toggle()
                        }) {
                            Image(systemName: isConfirmPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                
                // Sign Up Button
                Button(action: {
                    print("Sign Up tapped")
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .scrollDisabled(true)
    }
}

#Preview {
    SignUpView()
}
