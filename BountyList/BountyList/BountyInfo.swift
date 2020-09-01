//
//  BountyInfo.swift
//  BountyList
//
//  Created by Tony Jung on 2020/08/12.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

struct BountyInfo{
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
