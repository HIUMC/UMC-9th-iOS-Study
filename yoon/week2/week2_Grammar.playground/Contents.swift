import UIKit

var x = 5
x += 1
print(x)

var a = 10, b = 20
var sum = a + b
print(sum)

//var score = 80
//score >= 60 ? print("합격") : print("불합격")

var points = 120
var isMember = true

points >= 100 && isMember ? print("할인 가능") : print("할인 불가능")

for number in 1...5 {
    print(number, terminator: ",")
}

var temperature = 25
if temperature >= 30 {
    print("덥다")
}
else if temperature < 30 && temperature >= 10 {
    print("적당하다")
    }
else {
    print("춥다")
}

var day = 3

switch day {
case 1:
    print("월요일")
case 2:
    print("화요일")
case 3:
    print("수요일")
case 4:
    print("목요일")
case 5:
    print("금요일")
case 6:
    print("토요일")
case 7:
    print("일요일")
default:
    print("오류")
}

switch day {
case 1...5:
    print("주중")
case 6...7:
    print("주말")
default :
    print("오류")
}

var fruits:[String] = ["Apple", "Banana", "Cherry"]

for fruit in fruits {
    print(fruit)
}

var count:Int = 0

while count <= 5 {
    print("Count: \(count)")
    count+=1
}

var age:Int?

age = 25

if let Age = age {
    print(Age)
}

var score:Double?

score = 78.5

print("점수는 \(score!)점 입니다.")


