//
//  PhotosContentView.swift
//  PhotoPractice
//
//  Created by 박정환 on 11/29/25.
//

/*
import PhotosUI

@State private var selectedItems: [PhotosPickerItem] = []
@State private var images: [UIImage] = []

PhotosPicker(
    "사진 선택",
    selection: $selectedItems,
    maxSelectionCount: 3,
    matching: .images
)
.onChange(of: selectedItems) { newItems in
    for item in newItems {
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                images.append(image)
            }
        }
    }
}
*/

import SwiftUI
import PhotosUI

struct PhotoContentView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []

    var body: some View {
        VStack(spacing: 20) {
            PhotosPicker("📁 사진 선택하기", selection: $selectedItems, maxSelectionCount: 5, matching: .images)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(selectedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                    }
                }
            }
        }
        .padding()
        .onChange(of: selectedItems) { oldItems, newItems in
            selectedImages.removeAll()
            for item in newItems {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImages.append(image)
                    }
                }
            }
        }
    }
}

#Preview {
    PhotoContentView()
}
