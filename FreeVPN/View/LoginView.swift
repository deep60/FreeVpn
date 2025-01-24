//
//  LoginView.swift
//  FreeVPN
//
//  Created by P Deepanshu on 24/01/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswoordVisible = false
    @State private var selectedTab = 0
    @State private var isLoginError = false
    
    private func performLogin() {
        if email == "demo" && password == "password" {
            print("Login Successful")
            isLoginError = false
        } else {
            isLoginError = true
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("The VPN App is for free 1 month trial. Make sure you use accurate information.")
                    .font(.caption)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                
                HStack(alignment: .center) {
                    Button(action: { selectedTab = 0 }) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(selectedTab == 0 ? .white : .gray)
                            .padding()
                            .frame(width: 100)
                            .background(selectedTab == 0 ? Color.purple : Color.clear)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(selectedTab == 1 ? .white : .gray)
                            .padding()
                            .background(selectedTab == 1 ? Color.purple : Color.clear)
                            .cornerRadius(10)
                    }
                }
                //.background(Color.black)
                .cornerRadius(10)
                .padding()
                
                VStack(spacing: 16) {
                    Button(action: {
                        print("Sign Up with Goooogle Account")
                    }) {
                        HStack {
                            Image(systemName: "apple.terminal.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(Color.red)
                            Text("Sign up with Google")
                                .font(.headline)
                                .foregroundStyle(.black)
                        }
                        .padding()
                        .frame(width: 310)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    
                    Button(action: {
                        print("Sign up with apple account")
                    }) {
                        HStack {
                            Image(systemName: "apple.logo")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.black)
                            Text("Sign Up with Apple")
                                .font(.headline)
                                .foregroundStyle(.black)
                        }
                        .padding()
                        .frame(width: 310, height: 60)
                        .background(Color.gray)
                        .cornerRadius(40)
                    }
                }
                
                //Spacer()
                
                HStack(spacing: 10) {
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 1)
                        .fontWeight(.light)
                    
                    Text("Or better yet..")
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 1)
                        .fontWeight(.light)
                }
                .padding(.horizontal, 30)
                
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundStyle(.gray)
                        
                        TextField("Enter your email", text: $email)
                            .foregroundStyle(.white)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundStyle(.gray)
                        
                        if isPasswoordVisible {
                            TextField("Enter your password", text: $password)
                                .foregroundStyle(.white)
                        } else {
                            SecureField("Enter your password", text: $password)
                        }
                        
                        Button(action: {
                            isPasswoordVisible.toggle()
                        }) {
                            Image(systemName: isPasswoordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                Button(action: {
                    performLogin()
                }) {
                    Text("Login")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(email.isEmpty || password.isEmpty)
            }
        }
        //.background(Color.black).edgesIgnoringSafeArea(.all)
    }
}
 
#Preview {
    LoginView()
}
