//
//  SplashView.swift
//  Megabox
//
//  Created by 김지우 on 9/18/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center){
            Color(.white)
            
            VStack{
                Image(.megaboxLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 249, height: 84)
            }//VStack
        }//ZStack_end
        .ignoresSafeArea()//전체 화면에 흰색 배경

    }
}

#Preview {
    SplashView()
}
