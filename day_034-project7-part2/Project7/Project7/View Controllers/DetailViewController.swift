//
//  DetailViewController.swift
//  Project7
//
//  Created by JLCS on 4/15/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    // MARK: - Stored Properties
    var webView: WKWebView!
    var detailItem: Petition?

    // MARK: - View Lifecycle
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else {
            return
        }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
