//
//  ViewController.swift
//  Study01
//
//  Created by Tony Jung on 2020/09/12.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var count:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        image.isUserInteractionEnabled = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        image.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        image.addGestureRecognizer(swipeLeft)
    }


    @objc func swipeGesture(sender: UISwipeGestureRecognizer?){
        if let swipeGesture = sender{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                count-=1
                print("\(count)")
                image.image = UIImage(named: "image\(count)")
            case UISwipeGestureRecognizer.Direction.left:
                count+=1
                 print("\(count)")
                image.image = UIImage(named: "image\(count)")
            default:
                break
            }
        }
    }
    

    @IBAction func exitToLogin(_ sender: Any) {
        
    }
    
}

