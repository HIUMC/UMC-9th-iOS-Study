//
//  ContentView.swift
//  UMC_9th_WEEK9
//
//  Created by 박병선 on 11/26/25.
//
import SwiftUI

struct PhotoView: View {
    @State private var showImagePicker = false
    @State private var selectedImages: [UIImage] = []

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(selectedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                }
            }

            Button("앨범에서 사진 선택") {
                showImagePicker = true
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(images: $selectedImages, selectedLimit: 5)
            }
        }
    }
}

#Preview {
    PhotoView()
}
