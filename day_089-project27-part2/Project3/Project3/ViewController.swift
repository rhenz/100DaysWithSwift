//
//  ViewController.swift
//  Project1
//
//  Created by JLCS on 3/29/22.
//

/*
 Challenge:
 1. Use IB to select the text label inside your table view cell and adjust its size to something larger
 2. In tableview, show the image names in sorted order
 3. Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.
 */

import UIKit

class ViewController: UITableViewController {

    // MARK: - Stored Properties
    var pictures = [String]()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Storm Viewer"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                self.pictures.append(item)
            }
        }
        
        // Sort
        self.pictures.sort()
    }
    
    // MARK: - Private Methods
    @objc
    private func shareTapped() {
        let recommendationMessage = "Hey! This is an awesome app. Check this out on AppStore! https://apps.apple.com/ph/app/youtube-watch-listen-stream/id544007664"
        let vc = UIActivityViewController(activityItems: [recommendationMessage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}


// MARK: - Table View Datasource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pictures.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = self.pictures[indexPath.row]
        return cell
    }
}

// MARK: - Table View Delegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            vc.selectedImageName = pictures[indexPath.row]
            vc.selectedImageIndex = indexPath.row
            vc.totalNumberOfImages = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
