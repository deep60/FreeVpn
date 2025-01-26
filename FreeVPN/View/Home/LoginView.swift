//
//  LoginView.swift
//  FreeVPN
//
//  Created by P Deepanshu on 24/01/25.
//

import SwiftUI

struct LoginView: View {
    @State private var selectedTab = 0
    @Namespace var name
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 38) {
                
                if selectedTab == 0 {
                    Login()
                } else {
                    SignUpView()
                }
            }
            .padding()
        }
    }
}
 
#Preview {
    LoginView()
}

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswoordVisible = false
    @State private var selectedTab = 0
    @State private var isLoginError = false
    @Namespace var name
    
    private func performLogin() {
        if email == "demo" && password == "password" {
            print("Login Successful")
            isLoginError = false
        } else {
            isLoginError = true
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 15) {
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("The VPN App is for free 1 month trial. Make sure you use accurate information.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                
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
            }
            VStack(spacing: 15) {
                Button(action: {
                    print("Sign Up with Goooogle Account")
                }) {
                    HStack {
                        Image("glogo")
                            .resizable()
                            .frame(width: 34, height: 34)
                            .foregroundStyle(.red)
                        Text("Sign In with Google")
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
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
                            .frame(width: 34, height: 34)
                            .foregroundStyle(.gray)
                        Text("Sign In with Apple")
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
            
            HStack(spacing: 15) {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                
                Text("Or better yet..")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            }
            .padding(.horizontal)
            
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
                        Image(systemName: isPasswoordVisible ? "eye" : "eye.slash")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            
            NavigationLink(destination: {
                ForgetPassView()
            }, label: {
                Button(action: {
                    performLogin()
                }) {
                    Text("Forget Password?")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .underline()
                }.frame(maxWidth: .infinity, alignment: .bottomLeading)
            })
            
            Button(action: {
                performLogin()
            }) {
                Text("Log In")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(email.isEmpty || password.isEmpty)
        }
    }
}

//struct Sign: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var confirmPassword: String = ""
//    @State private var isPasswordVisible: Bool = false
//    @State private var isConfirmPasswordVisible: Bool = false
//    @State private var selectedTab = 1
//    @Namespace var name
//    
//    var body: some View {
//
//    }
//}
