import UIKit

//func calculateTotalPrice(total:Int, tip:Int) {
//    print("최종 결제 금액 : \(tip + total)원")
//}
//
//func checkTemperature (temp:Int) {
//    if temp >= 30 {print("덥다")}
//    else if temp >= 15 {print("적당하다")}
//    else {print("춥다")}
//}
//
//func printTravelBudget (city:String, Day:Int, Budget: Int) {
//    print("\(city)에서의 총 여행 예산은 \(Budget)원입니다.")
//}
//
//func getCurrentDate () {
//    let now=Date()
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd"
//    print("오늘 날짜: \(formatter.string(from: now))")
//}
//
//calculateTotalPrice(total: 20, tip: 20)
//checkTemperature(temp: 25)
//printTravelBudget(city: "서울", Day: 3, Budget: 300000)
//getCurrentDate()

//var addValue = {(number: Int) in
//    var sum = 0
//    for i in 1...number {
//   sum += i
//    }
//    return sum
//}

//let addValue: (Int) -> Int = { (1...$0).reduce(0, +) }
//
//print(addValue(5))
//let result = addValue(5)
//print(result)

//class BankAccount {
//let accountNumber: String
//private var initialBalance: Double
//    init(accountNumber: String, initialBalance: Double) {
//        self.accountNumber = accountNumber
//        self.initialBalance = initialBalance < 0 ? 0 : initialBalance
//    }
//    
//func deposit(amount: Double) {
//        self.initialBalance += amount
//    print("Deposited \(amount) Current balance: \( initialBalance)")
//    }
//    
//    func withdraw(amount: Double) {
//        if amount > initialBalance
//        {print("Insufficient funds. Current balance : \(initialBalance)")}
//            else {
//            self.initialBalance -= amount
//            print("Withdrawn \(amount), Current balance: \(initialBalance)")
//        }
//    }
//}
//
//let account = BankAccount(accountNumber: "123-456", initialBalance: 100.0)
//
//account.deposit(amount: 50.0) // 출력: "Deposited 50.0. Current balance: 150.0"
//account.withdraw(amount: 30.0) // 출력: "Withdrew 30.0. Current balance: 120.0"
//account.withdraw(amount: 200.0) // 출력: "Insufficient funds. Current balance: 120.0"

struct Car {
    var make: String
    var model: String
    var year: Int
    var mileage: Double
    var isRunning: Bool
    
    init(make: String, model: String, year: Int, mileage: Double, isRunning: Bool) {
        self.make = make
        self.model = model
        self.year = year
        self.mileage = mileage
        self.isRunning = isRunning
    }
    
    mutating func start() {
        if isRunning == false {
            isRunning = true
            print("차 시동 걸림")
        }
        else {
            print("차 이미 시동 중")
        }
    }
    mutating func stop() {
        if isRunning == true {
            isRunning = false
            print("차 시동 꺼짐")
        }
        else {
            print("차 이미 꺼짐")
        }
    }
    mutating func drive(distance: Double) {
        if isRunning == true {
            mileage += distance
            print("이동거리 \(distance)km. 현재 mileage: \(mileage)km")
        }
        else {
            print("이동 불가능. 차 시동 꺼짐")
        }
    }
}

var myCar = Car(make: "한국", model: "KIA", year: 2024, mileage: 15000.0, isRunning: false)

myCar.start() // 출력: "차 시동 걸림."
myCar.drive(distance: 100) // 출력: "이동거리 100 km. 현재 mileage: 15100 km"
myCar.stop() // 출력: "차 시동 꺼짐."
myCar.drive(distance: 50) // 출력: "이동 불가능. 차 시동 꺼짐."
myCar.start() // 출력: "차 시동 켜짐"
myCar.start() // 출력: "차 이미 시동 중."
