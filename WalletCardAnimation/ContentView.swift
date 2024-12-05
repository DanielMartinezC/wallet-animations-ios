//
//  ContentView.swift
//  WalletCardAnimation
//
//  Created by Daniel Martinez Condinanza on 5/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let safeArea = proxy.safeAreaInsets
            
            HomeView(size: size, safeArea: safeArea)
                .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    ContentView()
}
