//
//  CameraView.swift
//  UMC_9th_WEEK9
//
//  Created by 박병선 on 11/26/25.
//
import SwiftUI
import PhotosUI

struct CameraView: View {
    @State private var showCamera = false
    @State private var capturedImage: UIImage?

    var body: some View {
        VStack(spacing: 20) {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Text("사진을 찍어보세요!")
            }

            Button("📷 카메라 열기") {
                showCamera = true
            }
            .padding()
            .sheet(isPresented: $showCamera) {
                CameraPicker { image in
                    self.capturedImage = image
                }
            }
        }
        .padding()
    }
}

#Preview {
    CameraView()
}

