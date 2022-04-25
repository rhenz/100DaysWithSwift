//
//  ViewController.swift
//  Project10
//
//  Created by John Salvador on 4/25/22.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Store Properties
    var persons: [Person] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    // MARK: - Methods
    @objc
    func addNewPerson() {
        showSelectPhotoSheet()
    }
    
    private func showSelectPhotoSheet() {
        let actionSheet = UIAlertController(title: "Camera or Photo Library?", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
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
        
        let photoAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            // Select photo library
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            self?.present(picker, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    private func showRenamePersonAlert(for personIndex: Int) {
        let person = persons[personIndex]
        
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            
            self?.collectionView.reloadData()
        })
        
        present(ac, animated: true)
    }
    
    private func showRenameOrDeleteAlert(for personIndex: Int) {
        let ac = UIAlertController(title: "Rename or Delete", message: nil, preferredStyle: .alert)
        let rename = UIAlertAction(title: "Rename", style: .default) { [weak self] _ in
            self?.showRenamePersonAlert(for: personIndex)
        }
        let delete = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            
        }
        ac.addAction(delete)
        ac.addAction(rename)
        present(ac, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        persons.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // MARK: - UICollection Data Source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell")
        }
        
        let person = persons[indexPath.item]
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        
        cell.name.text = person.name
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    // MARK: - UICollection Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showRenameOrDeleteAlert(for: indexPath.item)
    }
}

