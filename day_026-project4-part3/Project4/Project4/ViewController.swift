//
//  ViewController.swift
//  Project4
//
//  Created by JLCS on 4/6/22.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Store Properties
    var webView: WKWebView!
    var progressView: UIProgressView!
    var selectedWebsite: String?
    
    // MARK: - View Lifecycle
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebsiteView()
        setupView()
    }
    
    // MARK: - Private Methods
    private func setupWebsiteView() {
        guard let unwrappedSelectedWebsite = selectedWebsite else { return }
        let url = URL(string: "https://" + unwrappedSelectedWebsite)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    private func setupView() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        navigationController?.isToolbarHidden = false
        
        // Setup progress view
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        // Create UIBarButtonItems for UIToolbar
        let backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, backButton, forwardButton,refresh]
        
    }
    
    /*
    @objc private func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
     
    
    private func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
     */
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        func showBlockedAlertView() {
            let ac = UIAlertController(title: "Blocked Website", message: "The website you are trying to access is not allowed", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(ac, animated: true)
        }
        
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in Website.allowedURLs {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        } else {
            // There is a case url host returns nil for some reason?
            decisionHandler(.allow)
            return
        }
        
        decisionHandler(.cancel)
        showBlockedAlertView()
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}



