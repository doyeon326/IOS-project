import Cocoa
//방법 1.
let evenNumbers: [Int] = [2, 4, 6, 8]
//let = 값을 변경하지 않을때 let을 쓴다!!!! -> 그래서 바꿀땐 var을 사용한다

//방법 2.
var evenNumbers2 : Array<Int> = [2, 4, 6, 8]

//1번에다가 10이라는 요소를 추가할때
evenNumbers2.append(10)
//다른 방법으로 추가
evenNumbers2 += [12, 14, 16]
//다른 방법으로 추가
evenNumbers2.append(contentsOf: [18,20])

//evenNumbers2 = [] //깡~통
//let isEmpty = evenNumbers2.isEmpty

evenNumbers2.count

//print(evenNumbers2.first) //왜 옵셔널? 값이 있을수도 있고 없을 수도 있기때문에.. ^^ 그래서 옵셔널 바인딩으로 해줘야한다.

//let firstItem = evenNumbers2.first

if let firstElement = evenNumbers2.first{
    print("first element is : \(firstElement)")
}


evenNumbers2.min() //값이 있을수도 있고 없을수도 있으므로 옵셔널~
evenNumbers2.max() // 세임~

//인덱스
var firstItemisthis = evenNumbers2[0]
var secondItem = evenNumbers2[1]
var lastItem = evenNumbers2[9]

let firstThree = evenNumbers[0...2] //이런식으로 Range를 가져올 수 있다.
firstThree

evenNumbers2.contains(3) //있는지 없는지 확인
evenNumbers2.contains(4)

evenNumbers2.insert(0, at: 0) //0번째 인덱스를 0 으로 바꿔랏

//evenNumbers2.removeAll() //다 지워라!
//evenNumbers2 = [] //이것도 다 지워라!!

evenNumbers2.remove(at: 0) //0번째 인덱스를 지워라.. !
evenNumbers2

evenNumbers2[0] = -2 //특정 인덱스값 업데이트
evenNumbers2

evenNumbers2[0...2] = [-2, 0, 2] //range 범위를 통째로 업데이트
evenNumbers2

evenNumbers2.swapAt(0, 9) //맨앞과 인덱스[9] 요소가 스왑되었다^^

//for num in evenNumbers2{
//    print(num)
//}

for (index, num) in evenNumbers2.enumerated(){//인덱스와 값을 가져올수 있는 포문
    print("idx: \(index), value: \(num)")
}

evenNumbers2.dropFirst(3) //앞에 3개를 없애고 보여주는거 하지만 값은 고대로 있음!
let firstThreeRemoved = evenNumbers2.dropFirst(3) //dropLast도 가능
evenNumbers2
firstThreeRemoved

firstThreeRemoved.dropLast() //마지막 지움

let firstThreeN = evenNumbers2.prefix(3) //앞에서 세개를 가져옴 하지만 본래의 값을 건드리진않음
firstThreeN

let lastThreeN = evenNumbers2.suffix(3) //뒤에서 세개를 가져옴
lastThreeN
