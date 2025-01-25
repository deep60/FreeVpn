//
//  ContentView.swift
//  FreeVPN
//
//  Created by P Deepanshu on 24/01/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            if UIScreen.main.bounds.height < 750 {
                ScrollView(.vertical, showsIndicators: false) {
                    LoginView()
                }
            } else {
                SignUpView()
            }
        }
    }
}

#Preview {
    ContentView()
}
