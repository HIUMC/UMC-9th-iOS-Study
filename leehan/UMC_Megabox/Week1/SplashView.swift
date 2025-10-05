//
//  SplashView.swift
//  UMC_Megabox
//
//  Created by OOng E on 9/16/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center){
            Rectangle()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(Color.white)
            Logo
        }
    }
    
    private var Logo: some View {
        Image("megaboxLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 249, height: 84)
    }
}

#Preview {
    SplashView()
}
