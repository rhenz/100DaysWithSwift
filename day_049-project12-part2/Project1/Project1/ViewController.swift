//
//  ViewController.swift
//  Project1
//
//  Created by JLCS on 3/29/22.
//

import UIKit

class ViewController: UITableViewController {

    // MARK: - Stored Properties
    var storms = [Storm]()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        if let savedStorms = load() {
            storms = savedStorms
        } else {
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    let storm = Storm(image: item)
                    self.storms.append(storm)
                }
            }
        }
        
        // Sort
        self.storms.sort()
    }
    
    // MARK: - Methods
    func load() -> [Storm]? {
        let defaults = UserDefaults.standard
        var savedStorms: [Storm] = []
        
        if let savedStormsData = defaults.object(forKey: "storms") as? Data {
            let jsonDecoder = JSONDecoder()
                
            do {
                savedStorms = try jsonDecoder.decode([Storm].self, from: savedStormsData)
            } catch {
                print("Failed to load storms")
                return nil
            }
        } else {
            return nil
        }
        
        return savedStorms
    }
    
    func save() {
        let jsonDecoder = JSONEncoder()
        if let savedData = try? jsonDecoder.encode(storms) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "storms")
        } else {
            print("Failed to save storms")
        }
    }
    
    func updateViewCount(at indexPath: IndexPath) {
        storms[indexPath.item].addViewCount()
        tableView.reloadRows(at: [indexPath], with: .none)
        save()
    }
}


// MARK: - Table View Datasource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let storm = self.storms[indexPath.item]
        content.text = storm.image
        content.secondaryText = "View Count: \(storm.viewCount)"
        
        // Assign content to configuration to cell
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table View Delegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController {
            updateViewCount(at: indexPath)
            vc.selectedImageName = storms[indexPath.row].image
            vc.selectedImageIndex = indexPath.row
            vc.totalNumberOfImages = storms.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
