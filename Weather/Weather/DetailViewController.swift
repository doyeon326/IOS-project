//
//  DetailViewController.swift
//  Weather
//
//  Created by Tony Jung on 2020/08/25.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
//**
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var weatherStat: UILabel!
    @IBOutlet weak var weatherFahrenheit: UILabel!
    @IBOutlet weak var weatherCelsius: UILabel!
    @IBOutlet weak var rainPosibility: UILabel!
    
    var celsius: String = ""
    var fahrenheit: String = ""
    var rain: String = ""
    var state: Int!
    var city: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = city
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weatherCelsius.text = "섭씨"+celsius+"도"
        weatherFahrenheit.text = "화씨"+fahrenheit+"도"
        rainPosibility.text = "강수확률"+rain+"%"
        
        switch state {
        case 10: weatherStat.text = "맑음"
        weatherImg.image=UIImage(named: "sunny")
        case 11:    weatherStat.text = "흐림"
                    weatherImg.image=UIImage(named: "cloudy")
        case 12:    weatherStat.text = "비옴"
                    weatherImg.image=UIImage(named: "rainy")
        case 13:    weatherStat.text = "눈옴"
                    weatherImg.image=UIImage(named: "snowy")
        default:    weatherStat.text = "맑음"
                    weatherImg.image=UIImage(named: "cloudy")
                
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
