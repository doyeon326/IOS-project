//
//  BountyViewController.swift
//  BountyList
//
//  Created by Tony Jung on 2020/08/07.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //MVVM
    
    //Model
    //-BountyInfo
    
    //View
    //-ListCell
    //>ListCell 필요한 정보를 ViewModel한테서 받아야겠다
    //>Listcell은 ViewModel로 부터 받은 정보를 뷰 업데이트 하기
    
    //ViewModel
    //-BountyViewModel
    //>BountyViewModel을 만들고, 뷰레이어에서 필요한 메서드 만들기
    //>모델 가지고 있기,, BountyInfo들
    
    let viewModel = BountyViewModel()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int{
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    //UICollectionViewDataSource
    //몇개를 보여줄까여?
    //셀은 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return viewModel.numOfBountyInfoList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
               return UICollectionViewCell()
           }
           let bountyinfo = viewModel.bountyInfo(at: indexPath.row)
           cell.update(info: bountyinfo)
           cell.update(info: bountyinfo)
           return cell
       }
    //UICollectionViewDelegate
    //셀이 클릭되었을때 어쩔까요?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("--> \(indexPath.item)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    //UICollectionViewDelegateFlowLayout
    //cell size를 계산할거다 (목표: 다양한 디바이스에서 일관/균형적인 디자인을 보여주기 위해)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height: CGFloat = width * 10/7 + textAreaHeight
        return CGSize(width: width, height: height)
    }
}

class BountyViewModel{
        let bountyInfoList: [BountyInfo] = [
           BountyInfo(name: "brook", bounty: 33000000),
           BountyInfo(name: "chopper", bounty: 50),
           BountyInfo(name: "franky", bounty: 4400000),
           BountyInfo(name: "luffy", bounty: 3300000),
           BountyInfo(name: "robin", bounty: 1600000),
           BountyInfo(name: "nami", bounty: 800000),
           BountyInfo(name: "sanji", bounty: 7700000),
           BountyInfo(name: "zoro", bounty: 12000000),
        ]
    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted { prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    func bountyInfo(at index: Int) -> BountyInfo{
        return sortedList[index]
    }
}

class GridCell: UICollectionViewCell{
      @IBOutlet weak var imgView: UIImageView!
      @IBOutlet weak var nameLabel: UILabel!
      @IBOutlet weak var BountyLabel: UILabel!
      
      func update(info: BountyInfo) {
          imgView.image = info.image
          nameLabel.text = info.name
          BountyLabel.text = "\(info.bounty)"
      }
      
  }
   
