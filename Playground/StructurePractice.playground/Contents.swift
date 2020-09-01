import Cocoa

//도전과제
//1. 강의 이름, 강사 이름, 학생수를 가지는 Struct 만들기
//2. 강의 어레이와 강사이름을 받아서, 해당강사의 강의 이름을 출력하는 함수 만들기
//3. 강의 3개 만들고 강사이름으로 강의 찾기

struct lecture{
    var teacher : String
    var subject : String
    var noOfStudent : Int
}

func printLectureInfo (lec : [lecture], teacher: String){
//    for i in lec{
//        if teacher == i.teacher{
//            print("\(i.teacher)님의 강의는: \(i.subject)입니다")
//        }
//    }
    
//closer 방법 :
    //방법1
//    let lectureName = lec.first{(lec) -> Bool in
//        return lec.teacher == teacher
//        }?.subject ?? " " //default 값
    
    //방법2
    let lectureName = lec.first{$0.teacher == teacher}?.subject ?? " " //default 값
    
    print("\(teacher)님의 강의는: \(lectureName)입니다")
}

let lecture1 = lecture(teacher: "이영걸", subject:"IT웹개발", noOfStudent: 12 )
let lecture2 = lecture(teacher: "이민희", subject:"IT앱개발", noOfStudent: 13 )
let lecture3 = lecture(teacher: "손새봄", subject:"IT웹/앱개발", noOfStudent: 15 )

let lectures = [lecture1, lecture2, lecture3]

printLectureInfo(lec: lectures, teacher: "손새봄")
 
//Protocol

 
