//
//  ViewController.swift
//  Animation
//
//  Created by Tony Jung on 2021/02/07.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Spring Animation

    @IBOutlet weak var bonacinno: UIView!
    
    @IBOutlet weak var simpleLabel: UILabel!
    var labelPositionisLeft = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func animateBtnDidtouch(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.bonacinno.backgroundColor = .brown
            self.bonacinno.frame.size.width += 10
            self.bonacinno.frame.size.height += 10
          
        }){ _ in
            UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                self.bonacinno.frame.origin.y -= 20
            })
        }
    }
    @IBAction func animateLabelBtnDidTouch(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            if self.labelPositionisLeft {
                self.simpleLabel.center.x = self.view.bounds.width - 100
            }
            else {
                self.simpleLabel.center.x = 100
            }
            self.labelPositionisLeft = !self.labelPositionisLeft
        }, completion: nil)
    }
}

