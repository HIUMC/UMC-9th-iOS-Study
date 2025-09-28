//
//  SplashView.swift
//  MEGABOX
//
//  Created by 박정환 on 9/17/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment:.center) {
            Color.white
                .ignoresSafeArea()

            Image(.meboxLogo)
        }
    }
}

#Preview {
    SplashView()
}
