//
//  SplashView.swift
//  MEGABOX
//
//  Created by 고석현 on 9/17/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
         
            Color.white
                .ignoresSafeArea()

        
            Image("megaboxLogo1")

                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 249, height: 84)
                .clipped()
        }
    }
}

#Preview {
    SplashView()
}
