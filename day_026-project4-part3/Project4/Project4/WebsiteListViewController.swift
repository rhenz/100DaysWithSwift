//
//  WebsiteListViewController.swift
//  Project4
//
//  Created by JLCS on 4/7/22.
//

import UIKit

class WebsiteListViewController: UITableViewController {
    
    // MARK: - Store Properties
    private var websites = Website.allowedURLs

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Simple Web Browser"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCellId", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toWebBrowserVC", sender: websites[indexPath.row])
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let destVC = segue.destination as? ViewController {
            destVC.selectedWebsite = sender as? String
        }
    }
}
