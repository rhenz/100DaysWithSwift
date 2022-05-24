//
//  NoteCell.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import UIKit

class NoteCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!
    
    
    // MARK: - Static Properties
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    // MARK: - Properties
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
    }
    
    
    
    // MARK: - Helper Methods
    
    // MARK: - Public API
    public func configure(with representable: NoteRepresentable) {
        titleLabel.text = representable.title
        descLabel.text = representable.content
        timeLabel.text = representable.date
        
        if representable.image == nil {
            noteImageView.isHidden = true
        } else {
            noteImageView.isHidden = false
            noteImageView.image = representable.image // Just for testing, this is a systemImage from test data
            
            //TODO: Set Image from persistence
        }
    }
}
