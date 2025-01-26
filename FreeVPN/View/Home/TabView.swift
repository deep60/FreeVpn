//
//  TabView.swift
//  FreeVPN
//
//  Created by P Deepanshu on 25/01/25.
//

import SwiftUI

struct TabView: View {
    @State private var index = 0
    var body: some View {
        VStack {
            if index == 0 {
                LoginView()
            } else {
                SignUpView()
            }
        }
    }
}
