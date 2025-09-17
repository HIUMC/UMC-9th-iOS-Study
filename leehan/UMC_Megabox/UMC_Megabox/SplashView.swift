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
                .foregroundStyle(Color.white)
            
            Logo
        }
    }
    
    private var Logo: some View {
        Image("megaboxLogo")
            .frame(width: 249, height: 84)
    }
}

#Preview {
    SplashView()
}
