//
//  ProfileImageView.swift
//  MegaBox
//
//  Created by 이서현 on 11/30/25.
//



import Foundation
import UIKit
import SwiftUI
import PhotosUI

struct ProfileImageView: View {
    @Binding var profileImage: UIImage?
    @State private var isShowingPhotoPicker: Bool = false
    @State private var selectedImages: [UIImage] = []

    var body: some View {
        let content: AnyView = {
            if let profileImage {
                return AnyView(
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFill()
                )
            } else {
                return AnyView(
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                )
            }
        }()

        return content
            .frame(width: 56, height: 56)
            .clipShape(Circle())
            .onLongPressGesture {
                isShowingPhotoPicker = true
            }
            .sheet(isPresented: $isShowingPhotoPicker) {
                ImagePicker(images: $selectedImages, selectedLimit: 1)
            }
            .onChange(of: selectedImages) { newValue in
                profileImage = newValue.first
            }
    }
}
