//
//  ViewController.swift
//  PresentViewControllerInFourWays
//
//  Created by Tony Jung on 2020/11/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveNext(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") else { return }
        
        vc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(vc, animated: true)
    }
    
    
    @IBAction func moveNextSecond(_ sender: Any) {
        let vc = SecondViewController()
        var view = UIView()
        view.backgroundColor = UIColor.blue
        vc.view = view
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func segwayTapped(_ sender: Any) {
        performSegue(withIdentifier: "segway", sender: nil)
    }
    
}

