//
//  DogViewModel.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/21/25.
//

import SwiftUI

@Observable
final class DogViewModel {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct DogParentView: View {
    // 소유/생명주기는 부모가 책임
    @State private var dog = DogViewModel(name: "Rex", age: 2)

    var body: some View {
        VStack(spacing: 16) {
            // 부모에서 값 변경 → 자식은 자동 갱신(plain property여도 관찰됨)
            Button("나이 +1") { dog.age += 1 }

            DogDetailView(dog: dog) // 수정 권한 없이 "읽기 전용"으로 전달
        }
        .padding()
    }
}

struct DogDetailView: View {
    // 부모가 내려준 모델을 "그냥 읽기"만 한다
    let dog: DogViewModel  // plain property

    var body: some View {
        VStack(spacing: 12) {
            Text("이름: \(dog.name)")
                .font(.title2)
            Text("나이: \(dog.age)")
                .font(.body)
        }
        .padding()
    }
}

#Preview {
    DogParentView()
}
