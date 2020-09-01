//
//  DetailViewController.swift
//  BountyList
//
//  Created by Tony Jung on 2020/08/08.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MVVM
    
    //Model
    //-BountyInfo
    //>BountyInfo 만들자
    
    //View
    //-imgView, nameLabel, bountylabel
    //>view들은 viewModel을 통해서 구성되기?
    
    //ViewModel
    //-DetailViewModel
    //>뷰레이어에서 필요한 메서드 만들기
    //>모델 가지고 있기.. BountyInfo 들
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var BountyLabel: UILabel!
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    private func prepareAnimation(){
//        nameLabelCenterX.constant = view.bounds.width
//        bountyLabelCenterX.constant = view.bounds.width
        
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        
        BountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        
        nameLabel.alpha = 0
        BountyLabel.alpha = 0
        
    }
    private func showAnimation(){ //기본 세팅값
//        nameLabelCenterX.constant = 0
//        bountyLabelCenterX.constant = 0
//
//// 기본:       UIView.animate(withDuration: 0.3){
////            self.view.layoutIfNeeded()
////        }
//
//// 디테일:       UIView.animate(withDuration: 0.3,
////                       delay: 0.1,
////                       options: .curveEaseIn,
////                       animations:{
////                        self.view.layoutIfNeeded()},completion: nil)
////스프링 반동:
//
//        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {self.view.layoutIfNeeded()}, completion: nil)
//
//        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
//
//
         UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            self.nameLabel.transform = CGAffineTransform.identity
            self.nameLabel.alpha = 1
           
         }, completion: nil)

        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
                self.BountyLabel.transform = CGAffineTransform.identity
                self.BountyLabel.alpha = 1
               }, completion: nil)
        
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    
    func updateUI(){
        if let bountyInfo = viewModel.bountyInfo{
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            BountyLabel.text = "\(bountyInfo.bounty)"
        }
        
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class DetailViewModel{
     var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?){
        bountyInfo = model
    }
}
