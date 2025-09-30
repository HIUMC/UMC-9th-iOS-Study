import UIKit

//var Dict: [String:Int] = ["Alice":80,"Bob":80,"Min":80]
//
//Dict["Alice"] = 95
//
//Dict["Bob"] = nil
//
//for (name,score) in Dict {
//    print("\(name)의 점수 \(score)")
//}

//Set를 사용하여 중복되지 않는 과일 목록을 관리하는 프로그램 작성
//
//1. Set를 사용하여 “Apple”, “Banana”, “Orange”를 추가하는 과일 목록을 선언
//2. “Banana”가 이미 존재하는지 확인하고, 존재하면 “Mango”를 추가하세요
//3. 세트에 있는 모든 과일을 반복문으로 출력하세요

//var FruitSet: Set<String> = ["Apple", "Banana", "Orange"]
//
//if FruitSet.contains("Banana") {
//    FruitSet.insert( "Mango" )
//}
//
//for (fruit) in FruitSet {
//    print(fruit)
//}

// 1. 네트워크 요청 상태 열거형 정의

enum State {
    case idle
    case requesting
    case success(String)
    case failure(String)
}

// 2. 네트워크 요청 상태를 나타내는 변수 선언

var currentState: State = .success("데이터 로드 완료")

// 3. switch문으로 상태에 맞는 출력 작성
switch currentState {
case .idle:
    print("현재 대기 상태입니다.")
case .requesting:
    print("요청 중입니다...")
case .success(let success):
    print("요청 성공: \(success)")
case .failure(let error):
    print("요청 실패: \(error)")
}
