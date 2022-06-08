//
//  ViewController.swift
//  milestone-project25-27
//
//  Created by John Salvador on 6/8/22.
//

import UIKit

class MemeGeneratorViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var setTopTextButton: UIButton!
    @IBOutlet weak var setBottomTextButton: UIButton!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    @IBOutlet weak var memeView: UIView!
    
    // MARK: -
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        return imagePicker
    }()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Views
        setupViews()
    }

    // MARK: - Helper Methods
    private func setupViews() {
        // Set Title of Navigation Bar
        title = "Meme Generator"
        
        // Create UIBarButtonItem on the right
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPhoto(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMeme(_:)))
        
        // Remove initial texts on labels
        topTextLabel.text = ""
        bottomTextLabel.text = ""
    }
    
    private func addMemeTextAlert(_ sender: UIButton) {
        let ac = UIAlertController(title: "Add Text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak ac, weak sender, weak self] _ in
            if let text = ac?.textFields?.first?.text {
                // Update Text Label
                if sender === self?.setTopTextButton {
                    self?.topTextLabel.text = text
                } else {
                    self?.bottomTextLabel.text = text
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    private func generateMeme() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: memeView.bounds)
        return renderer.image { context in
            memeView.layer.render(in: context.cgContext)
        }
    }
}

// MARK: - Actions

extension MemeGeneratorViewController {
    @objc private func importPhoto(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }
    
    @objc private func shareMeme(_ sender: UIBarButtonItem) {
        // Render Image and Text into one image
        let image = generateMeme().withRenderingMode(.alwaysOriginal)
        
        //
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
    }
    
    @IBAction private func setTopTextTapped(_ sender: UIButton) {
        addMemeTextAlert(sender)
    }
    
    @IBAction private func setBottomTextTapped(_ sender: UIButton) {
        addMemeTextAlert(sender)
    }
}

// MARK: - Image Picker Controller Delegate

extension MemeGeneratorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        // Show Buttons
        setTopTextButton.isHidden = false
        setBottomTextButton.isHidden = false
        
        // Set the image to ImageView
        imageView.image = image
        
        // Dismiss
        dismiss(animated: true)
    }
}

