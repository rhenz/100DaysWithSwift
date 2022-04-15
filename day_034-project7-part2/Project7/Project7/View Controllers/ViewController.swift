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
        
        var urlString: String
        switch navigationController?.tabBarItem.tag {
        case 0:
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        case 1:
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        default:
            urlString = ""
        }
        
//        if Int.random(in: 1...2) == 1 { urlString = "" } // Just to test the error alert view
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(jsonData: data)
                return
            }
        }
        
        // Parsing wasn't successful
        showError()
    }
    
    // MARK: - Private Methods
    private func parse(jsonData: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: jsonData) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    private func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
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

// MARK: - Table View Delegater
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
