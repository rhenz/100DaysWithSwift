//
//  ViewController.swift
//  Project25
//
//  Created by John Salvador on 6/1/22.
//

import UIKit
import MultipeerConnectivity

class ViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    var images = [UIImage]()
    
    // MARK: -
    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCAdvertiserAssistant?
    
    let serviceType = "proj25service"
    
    let randomMessages = ["Hello!", "Hope you are doing well!", "Have a nice day!", "God bless!"]
    
    private lazy var picker: UIImagePickerController = {
        // Initialize Image Picker Controller
        let picker = UIImagePickerController()
        
        // Configure Image Picker Controller
        picker.allowsEditing = true
        picker.delegate = self
        
        return picker
    }()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
        
        // Setup MCSession
        setupMCSession()
    }

    // MARK: - Helper Methods
    
    private func setupMCSession() {
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
    }
    
    private func setupView() {
        // Set Navigation Bar Title
        title = "Selfie Share"
        
        // Initialize Right Bar Button Items
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeButtonTapped))
        let showConnectedDevicesButton = UIBarButtonItem(image: UIImage(systemName: "person.3.fill"), style: .plain, target: self, action: #selector(showConnectedDevicesButtonTapped))
        
        // Add Navigation Left Bar Button Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        
        // Add Navigation Right Bar Button Item
        navigationItem.rightBarButtonItems = [composeButton, showConnectedDevicesButton]
    }

    // MARK: - Actions
    // Challenge #3
    @objc private func showConnectedDevicesButtonTapped(_ sender: UIBarButtonItem) {
        guard let mcSession = mcSession else {
            return
        }

        let message = mcSession.connectedPeers.map { String($0.displayName) }.joined(separator: "\n")
        
        let ac = UIAlertController(title: "Connected Devices", message: message , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc private func composeButtonTapped(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Send Image or Text", message: nil, preferredStyle: .actionSheet)
        
        let sendImage = UIAlertAction(title: "Send Image", style: .default) { [weak self] _ in
            if let picker = self?.picker {
                self?.present(picker, animated: true)
            }
        }
        
        let sendMessage = UIAlertAction(title: "Send Random Text", style: .default) { [weak self] _ in
            if let randomMessage = self?.randomMessages.randomElement() {
                self?.sendText(randomMessage)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(sendImage)
        ac.addAction(sendMessage)
        ac.addAction(cancel)
        
        present(ac, animated: true)
    }
    
    @objc private func showConnectionPrompt(_ sender: UIBarButtonItem) {
        
        // Initialize Alert Controller
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        
        // Configure Alert Controller
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    // MARK: - Alert Actions
    
    private func startHosting(action: UIAlertAction) {
        guard let mcSession = mcSession else {
            return
        }
        
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
    }
    
    private func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else {
            return
        }
        
        let mcBrowser = MCBrowserViewController(serviceType: serviceType, session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
}

// MARK: - Collection View Date Source

extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        
        // Configure Cell
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
        }
        
        return cell
    }
}

// MARK: - Image Picker Delegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Retrieve Image
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
        
        sendImage(image)
    }
    
    private func sendImage(_ image: UIImage) {
        // Send image to peers if you are connected to any
        if let imageData = image.pngData() {
            sendData(imageData)
        }
    }
    
    // Challenge #2
    private func sendText(_ text: String) {
        guard !text.isEmpty else { return }
        let textData = Data(text.utf8)
        sendData(textData)
    }
    
    private func sendData(_ data: Data) {
        // Check session
        guard let mcSession = mcSession else { return }
        
        // Check if there's any peers to send image
        if mcSession.connectedPeers.count > 0 {
            do {
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch {
                let ac = UIAlertController(title: "Send Error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }
    }
    
    
}


// MARK: - MC Session Delegate

extension ViewController: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
        switch state {
        case .notConnected:
            print("Not Connected: \(peerID.displayName)")
            
            // Challenge #1
            let ac = UIAlertController(title: "Disconnected", message: "\(peerID.displayName) has disconnected", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        case .connecting:
            print("Connecting: \(peerID.displayName)")
        case .connected:
            print("Connected: \(peerID.displayName)")
        @unknown default:
            print("Unknown state received: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // Load images received to collection view
        DispatchQueue.main.async { [unowned self] in
            if let image = UIImage(data: data) {
                self.images.insert(image, at: 0)
                self.collectionView.reloadData()
            } else {
                // Challenge #2
                let text = String(decoding: data, as: UTF8.self)
                let ac = UIAlertController(title: "Message from \(peerID.displayName)", message: text, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
}

// MARK: - MC Browser View Controller Delegate

extension ViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        print("DID FINISH")
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        print("Was Cancelled")
        dismiss(animated: true)
    }
}
