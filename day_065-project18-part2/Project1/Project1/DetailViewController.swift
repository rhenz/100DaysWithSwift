//
//  DetailViewController.swift
//  Project1
//
//  Created by JLCS on 3/29/22.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Stored Properties
    var selectedImageName: String?
    var selectedImageIndex: Int?
    var totalNumberOfImages: Int?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Challenge #2
        assert(selectedImageName != nil, "Selected Image must not be nil")
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageIndex = self.selectedImageIndex,
           let imageCount = self.totalNumberOfImages {
            self.title = "Picture \(imageIndex+1) of \(imageCount)"
        } else {
            setTitleToImageName()
        }
        
        setImageView()
    }
    
    private func setTitleToImageName() {
        if let imageName = selectedImageName {
            self.title = imageName
        }
    }
    
    private func setImageView() {
        if let imageName = selectedImageName {
            self.imageView.image = UIImage(named: imageName)
        }
    }
}
