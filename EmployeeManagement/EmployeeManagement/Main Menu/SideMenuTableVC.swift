//
//  SideMenuTableVC.swift
//  EmployeeManagement
//
//  Created by kings on 18/09/2019.
//  Copyright © 2019 kings. All rights reserved.
//

import UIKit

class SideMenuTableVC: UITableViewController {
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    let closeButton = UIButton()
    
    let titles = ["근무 관리", "- 출퇴근 관리", "- 휴무/조퇴 관리", "- 내 출근 정보", "알바 관리", "- 오늘의 미션", "- 알바 공고", "내 정보", "- 근로계약서 관리", "- 프로필 설정", "닫기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()   //공백 라인 없애기
        
        setProfileCell()
    }
    
    func setProfileCell() {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.brown
        self.tableView.tableHeaderView = headerView
        
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        self.nameLabel.text = "테스터"
        self.nameLabel.textColor = UIColor.white
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.nameLabel.backgroundColor = UIColor.clear
        
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 100, height: 30)
        self.emailLabel.text = "test@gmail.com"
        self.emailLabel.textColor = UIColor.white
        self.emailLabel.font = UIFont.systemFont(ofSize: 11)
        self.emailLabel.backgroundColor = UIColor.clear
        
        let defaultProfile = UIImage(named: "user.png")
        self.profileImage.image = defaultProfile
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        let closeBtnImage = UIImage(named: "close.png")
        self.closeButton.setImage(closeBtnImage, for: .normal)
        self.closeButton.frame = CGRect(x: 200, y: 20, width: 30, height: 30)
        
        headerView.addSubview(self.nameLabel)
        headerView.addSubview(self.emailLabel)
        headerView.addSubview(self.profileImage)
//        headerView.addSubview(self.closeButton)
    }
    
    func sideMenuListClickEvent(_ viewID: String) {
        
        if viewID != "Close" {
            
            let nextView = self.storyboard?.instantiateViewController(withIdentifier: viewID)
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.popToRootViewController(animated: false) //이전 화면 스택에서 제거??? -> 확인 필요
            target.pushViewController(nextView!, animated: false)    //선택한 메뉴 화면으로 이동
        }
        self.revealViewController()?.revealToggle(self) //사이드바 닫아주기
    }
    
//MARK: - TableView Delegate & DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let id = "MenuCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        //메뉴 셀 색상 지정
        if (self.titles[indexPath.row] == "근무 관리") ||
            (self.titles[indexPath.row] == "알바 관리") ||
            (self.titles[indexPath.row] == "내 정보") {
            cell.backgroundColor = UIColor(red:0.60, green:0.40, blue:0.20, alpha:0.3)
        }
        if (self.titles[indexPath.row].contains("-")) {
            cell.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        }
        
        //닫기 버튼 셀
        if (self.titles[indexPath.row] == "닫기") {
            cell.backgroundColor = UIColor.brown
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TODO: 메뉴 화면 만들어지면 storyboard identifier 지정해서 연결해주기
        switch indexPath.row {
        case 1: //출퇴근 관리
            sideMenuListClickEvent("WorkStateView")
            
        case 2: //휴무 조퇴 관리
            sideMenuListClickEvent("DayOffApprovalView")
            
        case 3: //내 출근 정보
            sideMenuListClickEvent("MyTimeSheetView")
            
        case 5: //오늘의 미션
            sideMenuListClickEvent("WorkStateView")
            
        case 6: //알바 공고
            sideMenuListClickEvent("WorkStateView")
            
        case 8: //근로계약서 관리
            sideMenuListClickEvent("WorkStateView")
            
        case 9: //프로필 설정
            sideMenuListClickEvent("WorkStateView")
            
        case 10: //프로필 설정
            sideMenuListClickEvent("Close")
            
        default:
            break
        }
        
    }
}
