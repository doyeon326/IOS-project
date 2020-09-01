//
//  BountyInfo.swift
//  BountyList
//
//  Created by joonwon lee on 2020/03/07.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
