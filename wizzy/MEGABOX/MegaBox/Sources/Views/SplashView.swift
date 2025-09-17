//
//  SplashView.swift
//  MegaBox
//
//  Created by 이서현 on 9/15/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(Color.white)
            Image(.megaboxLogo1)
                .resizable()
                .frame(width: 249, height: 84)
        }
    }
}

#Preview {
    SplashView()
}
