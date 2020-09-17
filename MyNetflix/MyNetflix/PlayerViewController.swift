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
        playerView.player = player
    }
    
    override func viewWillAppear(_ animated: Bool) { //바로 재생 되게끔 설정
        super.viewWillAppear(animated)
        play()
    }
    @IBAction func togglePlaybutton(_ sender: Any) {
        if player.isPlaying {
            pause()
        }
        else {
            play()
        }
    }
    
    func play(){
        player.play()
        playButton.isSelected = true
    }
    func pause(){
        player.pause()
        playButton.isSelected = false
    }
    
    func reset(){
        pause()
        player.replaceCurrentItem(with: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        reset()
        dismiss(animated: false, completion: nil)
    }
}

extension AVPlayer { //현제 곡이 진행중인지 아닌지
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
