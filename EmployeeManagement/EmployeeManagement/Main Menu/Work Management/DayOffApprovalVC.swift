//
//  DayOffApprovalVC.swift
//  EmployeeManagement
//
//  Created by kings on 18/09/2019.
//  Copyright © 2019 kings. All rights reserved.
//

import UIKit
import FSCalendar

class DayOffTableCell: UITableViewCell {
    
    @IBOutlet var lbDayOffCellDate: UILabel!
    @IBOutlet var lbDayOffCellReason: UILabel!
}

class DayOffApprovalVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource {
    
    let eventDate = ["20190908", "20190911", "20190922"]    // yyyy/MM/dd
    let testDate = ["09.08", "09.11", "09.22"]
    let testReason = ["반차(사유: 시험)", "휴무", "휴무"]
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet var tableViewDayOff: UITableView!
    
    var selectedDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCalendarStyle()
        calendar.delegate = self
        calendar.dataSource = self
        
        tableViewDayOff.delegate = self
        tableViewDayOff.dataSource = self
        
        self.navigationItem.title = "휴무/조퇴 관리"
        
        setSideMenuButton()
        setDayOffAddButton()
    }
    
    func setCalendarStyle() {
        
//        calendar.allowsMultipleSelection = true //여러날짜를 동시에 선택할 수 있도록
        
        //톤다운 블루 : UIColor(red:0.13, green:0.47, blue:0.86, alpha:1.0)
        //톤다운 레드 : UIColor(red:0.78, green:0.20, blue:0.16, alpha:1.0)
//        calendar.appearance.todayColor = UIColor(red:0.13, green:0.47, blue:0.86, alpha:1.0)
//        calendar.appearance.todaySelectionColor = UIColor.red
//        calendar.appearance.selectionColor = UIColor.red
        calendar.appearance.eventDefaultColor = UIColor(red:1.00, green:0.57, blue:0.14, alpha:1.0)
    }
    
    func setSideMenuButton() {
        
        if let revealVC = self.revealViewController() {
            
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "menu.png")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            
            self.navigationItem.leftBarButtonItem = btn
            
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    
    func setDayOffAddButton() {
        
        let btn = UIBarButtonItem()
        btn.image = UIImage(named: "plus.png")
        btn.target = self
        btn.action = #selector(showDayOffAddPopUp)
        
        self.navigationItem.rightBarButtonItem = btn
    }
    
    @objc func showDayOffAddPopUp() {
        
        if selectedDate == nil {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            selectedDate = dateFormatter.string(from: date)
        }

        print(selectedDate!)
        let popupVC = self.storyboard!.instantiateViewController(withIdentifier: "DayOffPopUpView") as! DayOffPopUpVC
        popupVC.strSelectedDate = selectedDate!
        popupVC.modalPresentationStyle = .overCurrentContext
        present(popupVC, animated: false, completion: nil)
    }
    
    
//MARK: - 달력 관련 함수
    
    //달력에 이벤트 표시
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        for dateStr in eventDate {
            print(dateFormatter.string(from: date))
            print(dateStr)
            if(dateFormatter.string(from: date) == dateStr)
            {
                return 1
            }
        }
        return 0
    }
    
    // 각 날짜에 특정 문자열을 표시할 수 있습니다. 이미지를 표시하는 메소드도 있으니 API를 참조하세요.
    private func calendar(calendar: FSCalendar, subtitleForDate date: NSDate) ->String? {
        return ""
    }

    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        selectedDate = dateFormatter.string(from: date)
    }
     
    // 스와이프를 통해서 다른 달(month)의 달력으로 넘어갈 때 발생하는 이벤트를 이 곳에서 처리할 수 있겠네요.
    private func calendarCurrentMonthDidChange(calendar: FSCalendar) {
        print(calendar)
    }
    
    
//MARK: - 테이블뷰 관련 함수
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let id = "DayOffCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! DayOffTableCell
        
        //라벨 텍스트 셋팅
        cell.lbDayOffCellDate.text = self.testDate[indexPath.row]
        cell.lbDayOffCellReason.text = self.testReason[indexPath.row]
        
        return cell;
    }
}
