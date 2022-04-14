//
//  ViewController.swift
//  Project7
//
//  Created by JLCS on 4/14/22.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Stored Properties
    var petitions: [Petition] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 0
        
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // we're ok to parse!
                parse(jsonData: data)
            }
        }
        
    }
    
    // MARK: - Private Methods
    private func parse(jsonData: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: jsonData) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    
}

// MARK: - Table View Datasource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Setup cell
        var content = cell.defaultContentConfiguration()
        content.text = petitions[indexPath.row].title
        content.secondaryText = petitions[indexPath.row].body
        content.textProperties.numberOfLines = 1
        content.secondaryTextProperties.numberOfLines = 1
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table View Delegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
