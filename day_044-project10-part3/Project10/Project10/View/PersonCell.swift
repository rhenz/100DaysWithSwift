//
//  PersonCell.swift
//  Project10
//
//  Created by John Salvador on 4/25/22.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var name: UILabel!
    
    // MARK: - Init
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        self.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        self.imageView.layer.borderWidth = 2
        self.imageView.layer.cornerRadius = 3
        self.layer.cornerRadius = 7
    }
}
