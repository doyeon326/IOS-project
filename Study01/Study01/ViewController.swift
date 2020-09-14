//
//  ViewController.swift
//  Study01
//
//  Created by Tony Jung on 2020/09/14.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var images = ["image1.jpg","image2.jpg","image3.jpg","image4.jpg"]

    @IBOutlet weak var pageControl:UIPageControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var skipToNextView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControllerSetting()
        swipeImageSetting()
        skipToNextView.isHidden = true
    }
    
    
    @objc func swipeGesture(sender: UISwipeGestureRecognizer?){
        
        if let swipeGesture = sender {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                pageControl.currentPage += 1
                imageView.image = UIImage(named: images[pageControl.currentPage])
                if pageControl.currentPage == images.count - 1{
                    skipToNextView.isHidden = false
                }
            case UISwipeGestureRecognizer.Direction.left:
                pageControl.currentPage -= 1
                    imageView.image = UIImage(named: images[pageControl.currentPage])
                  if pageControl.currentPage != images.count - 1{
                            skipToNextView.isHidden = true
                        }
            default:
                break
                
            }
        }
        
    }

    @IBAction func pageChanged(_ sender: UIPageControl) {
        imageView.image = UIImage(named: images[pageControl.currentPage])
    }
    
    func pageControllerSetting(){
        pageControl.numberOfPages = images.count
             pageControl.currentPage = 0
             pageControl.pageIndicatorTintColor = UIColor.lightGray //페이지 표시 색상 회색
             pageControl.currentPageIndicatorTintColor = UIColor.black //현재 표시 색상 검정
             imageView.image = UIImage(named: images[0])
    }
    
    func swipeImageSetting(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
               swipeRight.direction = UISwipeGestureRecognizer.Direction.right
               imageView.addGestureRecognizer(swipeRight)
               
               let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
               swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
               imageView.addGestureRecognizer(swipeLeft)
    }
 
    @IBAction func skipToNextView(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "login")else { return }
        self.present(nextVC, animated: true)
       }
}

