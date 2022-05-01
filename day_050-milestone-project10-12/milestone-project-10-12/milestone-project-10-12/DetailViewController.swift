//
//  DetailViewController.swift
//  milestone-project-10-12
//
//  Created by John Salvador on 5/1/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Stored Properties
    var babyPhoto: BabyPhoto?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let babyPhoto = babyPhoto {
            let imagePath = getDocumentsDirectory().appendingPathComponent(babyPhoto.imageURLString)
            imageView.image = UIImage(named: imagePath.path)
            self.title = babyPhoto.caption
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
