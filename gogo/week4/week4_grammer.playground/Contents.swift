////import SwiftUI
////
////// 1. "최종 결제 금액: (최종 결제 금액)원"과 같이 출력되도록 작성해주세요!
////func calculateTotalPrice(Price: Int, tip: Int) -> Int {
////        let sum = Price + tip
////        print("최종 결제 금액: \(sum)원")
////        return sum
////}
////
////
////// 2. "덥다", "춥다", "적당하다"와 같이 출력되도록 작성해주세요!
////func checkTemperature(temperature: Int) -> String {
////    if temperature > 30 {
////        print ("덥다")
////    } else if temperature < 10 {
////        print ("춥다")
////    } else {
////        print ("적당하다") // 섭씨 10~30도
////    }
////}
////
////
////// 3. "(여행지)에서의 총 여행 예산은 (총 예산)원입니다."와 같이 출력되도록 작성해주세요!
////func priintTravelBudget(destination: String, spendingNights: Int, dayBudget: Int) -> Int {
////    let sum  = spendingNights * dayBudget
////    print("\(destination)에서의 총 여행 예산은 \(sum)원입니다.")
////    return sum
////}
////
////
////// 4. "오늘 날짜: 2024-09-19"와 같이 오늘 날짜가 "YYYY-MM-DD" 형식으로 출력되도록 작성해주세요!
////
////
////import Foundation
////func getCurrentDate() -> String {
////    let date = Date()
////    let formatter = DateFormatter()
////    formatter.dateFormat = "yyyy-MM-dd"
////    print("오늘 날짜: \(formatter.string(from: date))")
////    return formatter.string(from: date)
////}
////
////getCurrentDate()
//
////// 1. Int 변수를 파라미터로 받는 addValue 클로저를 선언하고 출력해주세요! 값은 임의로 넣어주세요.
////let addValue = {(numb: Int) in
////    var sum : Int = 0
////    for x in 1...numb {
////        sum += x
////        
////    }
////    print(sum)
////    return sum
////}
////
////addValue(10)
////
////// 2. 1번에서 선언한 addValue 클로저를 $를 이용해 경량화 시킨 코드를 아래 넣어주세요!
////
////let addValue = {
////    var sum = 0
////    for x in 1...$0 {
////        sum += x
////    }
////    return sum
////}
//
//class BankAccount {
//
//import SwiftUI
//
//class BankAccount {
//    var accountNumber : String
//    private(set) var balance : Double
//    //init 초기화 메소드로 전달 받는 인자가 꼭 클래스의 프로퍼티(기본 속성 변수)일 필요는 없다.
//    
//    init(accountNumber : String, initialBalance : Double) {
//        self.accountNumber = accountNumber
//        if initialBalance >= 0 {
//            self.balance = initialBalance //객체의 프로퍼티 변수 balance에 저장하겠다 .
//        }
//        else {self.balance = 0}
//}
//    
//    func deposit(amount : Double) {
//        self.balance += amount
//        print("Deposited \(amount). Current Balance: \(balance)")
//    }
//    func withdraw(amount : Double) {
//        if amount > balance {
//            print("Insufficient funds.Current Balance: \(balance)")
//            
//        }
//        else {
//            self.balance -= amount
//            print("Withdrawn \(amount). Current Balance: \(balance)")
//        }
//    }
//}
//
//}
//
//
//
//struct Car {
///* 요구사항에 맞춰 구현해주세요! */
//
////struct는 선언된 프로퍼티 변경 불가. 변경시에는 mutating 키워드 사용.
////아래에서 isRunning이 변경계속 되므로 mutating func 로 선언.!!
//
//import SwiftUI
//
//struct Car {
//    var make: String
//    var model: String
//    var year: Int
//    var mileage: Double
//    var isRunning: Bool
//    
//    init(make: String, model: String, year: Int, mileage: Double, isRunning: Bool) {
//        self.make = make
//        self.model = model
//        self.year = year
//        self.mileage = mileage
//        self.isRunning = isRunning
//    }
//    
//    
//    mutating func start() {
//        if isRunning {
//            print("차 이미 시동 중.")
//        } else {
//            isRunning = true
//            print("차 시동 걸림.")
//        }
//}
//    
//    mutating func stop() {
//        if isRunning{
//            isRunning = false
//            print("차 시동 꺼짐.")
//        } else {
//            print("차 이미 꺼짐.")
//        }
//    
//    }
//    
//    mutating func drive(distance : Double) {
//        if !isRunning {
//            print("이동 불가능. 차 시동 꺼짐.")
//        } else {
//            mileage += distance
//            print("이동거리 \(distance) km. 현재 mileage: \(mileage) km")
//        }
//   }
//    
//}
//
//}
