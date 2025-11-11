//
//  CustomButton.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/20/25.
//

import SwiftUI

struct CustomButton: View {
    
    @Binding var isClicked: Bool
    
    init(isClicked: Binding<Bool>) {
        self._isClicked = isClicked
    }
    
    var body: some View {
        Button(action: {
            isClicked.toggle()
            print("하위 뷰에서 클릭해서 값 변경함 : \(isClicked)")
        }, label: {
            Text("상위 뷰의 값을 State 값 변경")
        })
    }
}
