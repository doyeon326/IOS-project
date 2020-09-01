//
//  Countries.swift
//  Weather
//
//  Created by Tony Jung on 2020/08/25.
//  Copyright © 2020 Tony Jung. All rights reserved.


import Foundation

struct Countries: Codable{
        let korean_name: String
        let asset_name: String
}

struct Cities: Codable{
        
        let city_name: String
        let state: Int
        let celsius: Double
        let rainfall_probability: Int
 
    
    var fahrenheit: Double {
        let fahrenheit: Double = celsius * 9 / 5 + 32
        return (fahrenheit*10).rounded()/10
    }
}

