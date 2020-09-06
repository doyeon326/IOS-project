//
//  AlbumCollectionViewCell.swift
//  Album
//
//  Created by Tony Jung on 2020/09/01.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        albumImage.layer.cornerRadius = 4
    }
}
