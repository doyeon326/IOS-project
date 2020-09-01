//
//  Country.swift
//  MyWeather
//
//  Created by Tony Jung on 2020/08/25.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import Foundation
//    "city_name":"아를",
//        "state":11,
//        "celsius":22.5,
//        "rainfall_probability":80


// {"korean_name":"일본","asset_name":"jp"}
struct Country: Codable {
    let korean_name: String
    let asset_name: String
    
}

struct City: Codable{
    
    let city_name: String
    let state: Int
    let celsius: Double
    let rainfall_probability: Int
    
}
