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
    
    @objc func shareTapped() {
        
        guard let image = imageView.image else {
            fatalError("Image not available")
        }
        
        let modifiedImage = drawImagesAndText(with: image)
        
        let vc = UIActivityViewController(activityItems: [modifiedImage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    private func drawImagesAndText(with image: UIImage) -> UIImage {
        
        let width = image.size.width
        let height = image.size.height
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let img = renderer.image { ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 25),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "From Storm Viewer"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 0, y: 32, width: width, height: height), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        }
        
        return img
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
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
