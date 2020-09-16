//
//  PlayerViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/01.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var controlView: UIView!
    let player = AVPlayer()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscapeRight
        //landscape만하면 모든 방향 회전 가능 하지만 Right 하면 한쪽만 가능!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func togglePlaybutton(_ sender: Any) {
        playButton.isSelected = !playButton.isSelected
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

extension AVPlayer { //현제 곡이 진행중인지 아닌지
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
