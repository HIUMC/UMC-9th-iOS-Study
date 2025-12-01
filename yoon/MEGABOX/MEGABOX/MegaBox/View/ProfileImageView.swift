//
//  ProfileImageView.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/27/25.
//

import Foundation
import SwiftUI
import PhotosUI

struct ProfileImageView: View {
    @Binding var uiImage: UIImage?
    @State private var isShowingPhotoPicker: Bool = false
    
    var body: some View {
        Group {
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                
            } else {
                Image(.defaultprofile)
                    .resizable()
            }
        }
        .frame(width: 56, height: 56)
        .clipShape(Circle())
        .onLongPressGesture (
            minimumDuration:1.0) { isShowingPhotoPicker = true
            }
            .sheet(isPresented: $isShowingPhotoPicker) {
            ImagePicker(images: $uiImage)
        }
    }
}

#Preview {
    ProfileImageView(uiImage: .constant(nil)) // 기본 이미지를 표시하도록 nil 전달
}
