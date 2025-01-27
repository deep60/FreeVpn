//
//  AuthView.swift
//  FreeVPN
//
//  Created by P Deepanshu on 26/01/25.
//

import SwiftUI

enum AuthType {
    case login
    case signUp
}

struct AuthView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var authType: AuthType = .login
    
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var isLoginError = false
    @State private var hasAgreedToTerm = false
    
    @FocusState private var isEmailFoocused
    @FocusState private var isPassFocused
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            SegmentedView(authType: $authType)
            
            SocialApp()
            
            HStack(spacing: 15) {
                Rectangle()
                    .foregroundStyle(Color.gray.opacity(0.5))
                    .frame(height: 1.5)
                
                Text("Or better yet..")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                Rectangle()
                    .foregroundStyle(Color.gray.opacity(0.5))
                    .frame(height: 1.5)
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            VStack(spacing: 15) {
                ZStack() {
                    
                    TextField("Enter your email", text: $email)
                        .foregroundStyle(.white)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .textFieldStyle(AuthTextFieldStyle(isFocused: $isEmailFoocused))
                
                ZStack {
                    
                    TextField(text: $password) {
                        Text("Enter your password")
                    }
                    .focused($isPassFocused)
                    .textFieldStyle(AuthTextFieldStyle(isFocused: $isPassFocused))
                    .overlay(alignment: .trailing, content: {
                        Button {
                            withAnimation {
                                isPasswordVisible.toggle()
                            }
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                .padding()
                                .foregroundStyle(Color(UIColor.lightGray))
                        }
                    })
                    .opacity(isPasswordVisible ? 1 : 0)
                    .zIndex(1)
                    
                    SecureField(text: $password) {
                        Text("Enter your password")
                    }
                    .focused($isPassFocused)
                    .textFieldStyle(AuthTextFieldStyle(isFocused: $isPassFocused))
                    .overlay(alignment: .trailing) {
                        Button {
                            withAnimation {
                                isPasswordVisible.toggle()
                            }
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                .padding()
                                .foregroundStyle(Color(UIColor.lightGray))
                        }
                    }
                    .opacity(isPasswordVisible ? 0 : 1)
                }
                
                if authType == .signUp {
                    HStack(alignment: .top) {
                        Toggle(isOn: $hasAgreedToTerm) {
                            
                        }
                        .toggleStyle(AgreeStyle())
                        
                        Text("I agree to the **Terms** and **Privacy Policy**")
                    }
                }
            }
            
            BottomView(authType: $authType)
            
            Button {
                
            } label: {
                Text(authType == .login ? "Login" : "Sign Up")
            }
            .buttonStyle(AuthButtonType())
        }
        .padding()
    }
}

struct AgreeStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
        }
    }
}

#Preview {
    AuthView()
}

struct AuthButtonType: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .foregroundStyle(Color.white)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .background(
                LinearGradient(stops: [
                    .init(color: .purple, location: 0.0),
                    .init(color: .blue, location: 1.0)
                ], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(15)
            .brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .padding(.vertical, 12)
    }
}

struct SegmentedView: View {
    @Binding var authType: AuthType
    @Namespace var name
    
    var body: some View {
        HStack(spacing: 18) {
            Button {
                withAnimation(.spring()) {
                    authType = .login
                }
            } label: {
                VStack {
                    Text("Log In")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(authType == .login ? .white : .gray)
                    
                    ZStack {
                        Capsule()
                            .fill(Color.black.opacity(0.4))
                            .frame(height: 4)
                        
                        if authType == .login {
                            Capsule()
                                .fill(Color.purple)
                                .frame(height: 4)
                                .matchedGeometryEffect(id: "Tab", in: name)
                        }
                    }
                }
            }
            
            Button {
                withAnimation(.spring()) {
                    authType = .signUp
                }
            } label: {
                VStack {
                    Text("Sign Up")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(authType == .signUp ? .white : .gray)
                    
                    ZStack {
                        Capsule()
                            .fill(Color.black.opacity(0.4))
                            .frame(height: 4)
                        
                        if authType == .signUp {
                            Capsule()
                                .fill(Color.purple)
                                .frame(height: 4)
                                .matchedGeometryEffect(id: "Tab", in: name)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
    }
}

struct AuthTextFieldStyle: TextFieldStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    let isFocused: FocusState<Bool>.Binding
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(isFocused.wrappedValue ? Color.blue : Color.gray.opacity(0.5), lineWidth: 1)
                        .zIndex(1)
                    
                    RoundedRectangle(cornerRadius: 18)
                        .fill(colorScheme == .light ? Color(.lightGray) : Color(uiColor: UIColor.darkGray))
                        .zIndex(0)
                }
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused.wrappedValue)
    }
}

struct BottomView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var authType: AuthType
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 3) {
                Text(authType == .login ? "Don't have an account?" : "Already have an account?")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                
                Button {
                    if authType == .login {
                        withAnimation {
                            authType = .signUp
                        }
                    } else {
                        withAnimation {
                            authType = .login
                        }
                    }
                } label: {
                    Text(authType == .login ? "SignUp" : "Login")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                }
            }
        }
    }
}

struct SocialApp: View {
    var body: some View {
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
                        .frame(width: 32, height: 32)
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
    }
}
