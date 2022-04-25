//
//  StormCell.swift
//  Project1
//
//  Created by John Salvador on 4/26/22.
//

import UIKit

class StormCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.layer.cornerRadius = 20
    }
}
