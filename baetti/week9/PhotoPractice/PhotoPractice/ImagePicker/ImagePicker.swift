//
//  ImagePicker.swift
//  PhotoPractice
//
//  Created by 박정환 on 11/29/25.
//

/*
 <key>NSPhotoLibraryUsageDescription</key>
 <string>사진 앨범 접근 권한이 필요합니다.</string>
 */

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable { // SwiftUI에서 사용하기 위한 브릿지 프로토콜
    @Environment(\.dismiss) var dismiss
    @Binding var images: [UIImage]
    var selectedLimit: Int

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.selectionLimit = selectedLimit
        config.filter = .images

            let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.dismiss()

            for result in results {
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.images.append(image)
                        }
                    }
                }
            }
        }
    }
}
