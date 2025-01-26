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
    
    @FocusState private var isEmailFoocused
    @FocusState private var isPassFocused
    var body: some View {
        SegmentedView(authType: $authType)
        
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "envelope")
                    .foregroundStyle(.gray)
                
                TextField("Enter your email", text: $email)
                    .foregroundStyle(.white)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .textFieldStyle(AuthTextFieldStyle(isFocused: $isEmailFoocused))
            
            ZStack {
                Image(systemName: "lock")
                    .foregroundStyle(.gray)
                
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
                .zIndex(1)
            }
        }
    }
}

#Preview {
    AuthView()
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
