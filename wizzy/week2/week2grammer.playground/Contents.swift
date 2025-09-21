
import Foundation

// 1. 단항 연산자
var x = 5
x += 1
print(x)

// 2. 이항 연산자
let a = 10
let b = 20
let sum = a + b
print(sum)

// 3. 삼항 연산자
let score = 60
let result = score >= 60 ? "합격" : "불합격"
print(result)

// 4. 논리 연산자
let isMember = true
let points = 120
if isMember && points >= 100 {
    print("할인 가능")
} else {
    print("할인 불가능")
}

// 5. 범위 연산자
let numbers = 1...5
for number in numbers {
    if number == numbers.last {   // 마지막 원소 확인
        print(number)
    } else {
        print("\(number), ", terminator: "")
    }
}


// 2-1.

let temperature = 25

if temperature >= 30 {
    print("덥다")
} else if temperature >= 10 {
    print("적당하다")
} else {
    print("춥다")
}


// 2-2.
let day = 6

switch day {
case 1...5:
    print("주중")
case 6, 7:
    print("주말")
default:
    print("x")
}


//3-1.
let fruits = ["Apple", "Banana", "Cherry"]

for fruit in fruits {
    print(fruit)
}

//3-2.
var count = 0

while count <= 5 {
    print("Count: \(count)")
    count += 1
}


//4-1.

var age: Int? = nil    // 옵셔널 정수형 변수 선언 및 nil 할당

age = 25               // 값 할당

if let safeAge = age { // 안전하게 언래핑
    print("나이는 \(safeAge) 입니다.")
} else {
    print("Age 값이 없습니다.")
}

//4-2.
var score2: Double? = nil  // 옵셔널 Double 변수 선언 및 nil 할당

score2 = 78.5              // 값 할당

print("점수는 \(score2!) 입니다.") // 강제 언래핑 후 출력
