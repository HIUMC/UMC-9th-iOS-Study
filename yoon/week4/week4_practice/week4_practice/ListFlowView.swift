//
//  ListFlowView.swift
//  week4_practice
//
//  Created by 정승윤 on 10/7/25.
//

import SwiftUI
import Combine

struct ListFlowView: View {
    @StateObject private var vm = ListFlowViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            if vm.isLoading {
                ProgressView("불러오는 중…")
                    .padding(.vertical, 8)
            }
            
            if let err = vm.errorMessage {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text(err)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .foregroundStyle(.red)
                .padding(.horizontal)
            }
            
            List(vm.items, id: \.self) { item in
                Text(item)
            }
            .overlay {
                if vm.items.isEmpty && !vm.isLoading && vm.errorMessage == nil {
                    ContentUnavailableView(
                        "항목이 없습니다",
                        systemImage: "tray",
                        description: Text(
                            "아래 버튼으로 데이터를 불러와 보세요."))
                }
            }
            
            HStack {
                Button {
                    vm.onReloadTap()
                } label: {
                    Label("다시 불러오기", systemImage: "arrow.clockwise")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(vm.isLoading)
                
                Button(role: .destructive) {
                    vm.errorMessage = nil
                    vm.items = []
                } label: {
                    Label("초기화", systemImage: "xmark.circle")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(vm.isLoading)
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
    }
}

#Preview  {
    ListFlowView()
}
