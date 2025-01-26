//
//  ForgotPassView.swift
//  FreeVPN
//
//  Created by P Deepanshu on 24/01/25.
//

import SwiftUI

struct ForgetPassView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            NavigationStack {
                VStack(spacing: 8) {
                    Text("Forget Password?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    Text("Enter yoour email to reset your password. We will send the code to the email so you can reset password")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                    //.navigationTitle("Forget Password")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                                .frame(width: 40, height: 40)
                                .background(Circle().fill(Color.purple))
                        }
                    }
                    //Spacer()
                }
            }
        }
    }
}

#Preview {
    ForgetPassView()
}
