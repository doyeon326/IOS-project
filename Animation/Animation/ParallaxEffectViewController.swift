//
//  ParallaxEffectViewController.swift
//  Animation
//
//  Created by Tony Jung on 2021/02/07.
//

import UIKit

class ParallaxEffectViewController: UIViewController {
    //MARK: Motion effects in Swift

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parallaxEffect()
        
    }
    
    private func parallaxEffect(){
        let min = CGFloat(-30)
        let max = CGFloat(30)
              
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
              
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongHorizontalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
              
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]

        imageView.addMotionEffect(motionEffectGroup)
    }
}
