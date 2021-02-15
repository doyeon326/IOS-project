//
//  UIAnimationViewController.swift
//  Animation
//
//  Created by Tony Jung on 2021/02/15.
//

import UIKit

class UIAnimationViewController: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //
//        self.animationView.backgroundColor = .magenta
//        self.animationView.alpha = 0.5
//        self.animationView.center.x = self.view.bounds.width - 100
    
    }
    
    @IBAction func animateBtnDidTouch(_ sender: Any) {
        
        UIView.animateKeyframes(withDuration: 4, delay: 0, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                self.animationView.backgroundColor = .magenta
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.animationView.alpha = 0.5
            })
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25, animations: {
                self.animationView.center.x = self.view.bounds.width - 100
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                self.animationView.center.x = self.view.bounds.width - 200
            })
        })
    }
}
