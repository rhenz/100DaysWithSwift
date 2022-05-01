//
//  ViewController.swift
//  milestone-project-10-12
//
//  Created by John Salvador on 5/1/22.
//

import UIKit

struct BabyPhoto: Codable {
    var caption: String = "*no caption*"
    var imageURLString: String
}

class ViewController: UITableViewController {
    
    // MARK: - Stored Properties
    var babyPictures = [BabyPhoto]()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewBabyPicture))
        loadImages()
    }
    
    // MARK: - Private Methods
    @objc
    private func addNewBabyPicture() {
        
        let actionSheet = UIAlertController(title: "Add Photo", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.delegate = self
                self?.present(picker, animated: true)
            } else {
                print("Camera not available")
            }
        }
        
        let photoAlbum = UIAlertAction(title: "Photo", style: .default) { [weak self] _ in
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            self?.present(picker, animated: true)
        }
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photoAlbum)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    private func saveImages() {
        if let data = try? JSONEncoder().encode(babyPictures) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "babyPictures")
        } else {
            print("Failed to save baby pictures")
        }
    }
    
    private func loadImages() {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "babyPictures") as? Data {
            do {
                let pictures = try JSONDecoder().decode([BabyPhoto].self, from: data)
                babyPictures = pictures
            } catch {
                print("Failed to decode image data")
            }
        }
    }
}

// MARK: - UIImagePickerController
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
                
        dismiss(animated: true) {
            let ac = UIAlertController(title: "Add Caption", message: nil, preferredStyle: .alert)
            ac.addTextField { textField in
                textField.placeholder = "never leave this blank"
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { [weak ac, weak self]_ in
                guard let weakSelf = self else { return }
                
                if let text = ac?.textFields?[0].text {
                    let babyPhoto = BabyPhoto(caption: text, imageURLString: imageName)
                    weakSelf.babyPictures.append(babyPhoto)
                    
                    // Update Table View
                    weakSelf.tableView.beginUpdates()
                    let indexPath = IndexPath(row: weakSelf.babyPictures.count-1, section: 0)
                    weakSelf.tableView.insertRows(at: [indexPath], with: .automatic)
                    weakSelf.tableView.endUpdates()
                    
                    weakSelf.saveImages()
                }
            }
            ac.addAction(okAction)
            
            self.present(ac, animated: true)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func addCaption() {
        
    }
}

// MARK: - Tableview Data Source
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        babyPictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        
        let babyPicture = babyPictures[indexPath.item]
        
        // Configure cell
        var content = cell.defaultContentConfiguration()
        content.text = babyPicture.caption
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Tableview Delegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let destVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            destVC.babyPhoto = babyPictures[indexPath.item]
            navigationController?.pushViewController(destVC, animated: true)
        }
    }
}

