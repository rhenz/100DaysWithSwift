//
//  DetailViewController.swift
//  Project16
//
//  Created by John Salvador on 5/12/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    let webView = WKWebView()
    var capital: String
    
    init?(coder: NSCoder, capital: String) {
        self.capital = capital
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:capital:)` to initialize a DetailViewController instance")
    }
    
    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://en.wikipedia.org/wiki/\(capital)") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
