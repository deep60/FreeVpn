//
//  TabView.swift
//  FreeVPN
//
//  Created by P Deepanshu on 25/01/25.
//

import SwiftUI

struct TabView: View {
    @State private var selectedTab = 0
    var body: some View {
        VStack {
            if selectedTab == 0 {
                LoginView()
            } else {
                SignUpView()
            }
        }
    }
}
