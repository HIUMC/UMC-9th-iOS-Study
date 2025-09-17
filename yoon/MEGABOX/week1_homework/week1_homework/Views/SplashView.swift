//
//  SplashView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/15/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack(alignment: .center){
            Image(.meboxLogo1)
        }.background(Color.white)
    }
}
    
struct SplashView_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            SplashView()
        }
    }
}
