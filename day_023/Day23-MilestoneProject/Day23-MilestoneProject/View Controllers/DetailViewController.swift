//
//  DetailViewController.swift
//  Day23-MilestoneProject
//
//  Created by JLCS on 4/6/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    // MARK: - Store Properties
    var country: String?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        // Add border to imageview
        countryImageView.layer.borderWidth = 1
        countryImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        if let unwrappedCountry = country {
            countryImageView.image = UIImage(named: "\(unwrappedCountry).png")
            countryLabel.text = unwrappedCountry
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        } else {
            // Default
            countryLabel.text = "Something went wrong"
            countryImageView.image = UIImage(systemName: "xmark.octagon.fill")
        }
    }
    
    // MARK: - Private Methods
    @objc
    private func shareTapped() {
        if let unwrappedCountry = country, let imageName = UIImage(named: "\(unwrappedCountry).png")
        {
            let avc = UIActivityViewController(activityItems: [imageName, unwrappedCountry], applicationActivities: [])
            avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(avc, animated: true)
        }
    }
}
