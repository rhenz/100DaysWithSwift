//
//  ViewController.swift
//  Day23-MilestoneProject
//
//  Created by JLCS on 4/6/22.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Stored Properties
    var countries: [String] = []

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountryImageFiles()
    }

    // MARK: - Private Methods
    private func loadCountryImageFiles() {
        let fm = FileManager.default
        let bundle = Bundle.main.bundleURL
        let assetURL = bundle.appendingPathComponent("CountryFlagImages.bundle") // happy path
//        let assetURL = bundle.appendingPathComponent("CountryFlagImagesss.bundle") // sad path
        
        do {
            let items = try fm.contentsOfDirectory(atPath: assetURL.path)
            for item in items {
                if let country = item.split(separator: ".").first {
                    countries.append(String(country))
                }
            }
        } catch {
            let ac = UIAlertController(title: "Error", message: "Failed to loud country images: \(error.localizedDescription)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
}


// MARK: - Table View Datasource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = countries[indexPath.row]
        let imageName = "\(countries[indexPath.row]).png"
        content.image = UIImage(named: imageName)
        content.imageProperties.maximumSize = CGSize(width: 60, height: 40)
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table View Delegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let destVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            let randomNum = Int.random(in: 1...2)
            if randomNum == 1 {
                // happy path
                destVC.country = countries[indexPath.row]
            } else {
                // sad path
                destVC.country = nil
            }
            
            navigationController?.pushViewController(destVC, animated: true)
        }
    }
}




