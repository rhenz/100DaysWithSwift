//
//  ViewController.swift
//  Project13
//
//  Created by John Salvador on 5/3/22.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intensitySlider: UISlider!
    
    // MARK: - Stored Properties
    var currentImage: UIImage!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }
    
    // MARK: - Selector Methods
    @objc
    private func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated:  true)
    }

    // MARK: - IBActions
    @IBAction func changeFilter(_ sender: UIButton) {
        
    }
    
    @IBAction func save(_ sender: UIButton) {
        
    }
    
    @IBAction func intensitySliderChanged(_ sender: UISlider) {
        
    }
}


// MARK: - Image Picker Controller Delegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
    }
}
