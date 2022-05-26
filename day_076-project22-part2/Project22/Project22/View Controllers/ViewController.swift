//
//  ViewController.swift
//  Project22
//
//  Created by John Salvador on 5/25/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var distanceReadingLabel: UILabel!
    
    // MARK: - Properties
    var locationManager: CLLocationManager?
    
    var beacons: [String: String] = [
        "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5": "iPhone #1",
        "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0": "iPhone #2",
        "74278BDA-B644-4520-8F0C-720EAF059935": "iPhone #3"
    ]
    
    var beaconDetectedAlertShow = false
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }
    
    // MARK: - Helper Methods
    func startScanning() {
//        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
//        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
//        locationManager?.startMonitoring(for: beaconRegion)
//        locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        
        
        for beacon in beacons {
            print("Registering: \(beacon.key) - \(beacon.value)")
            let beaconRegion = CLBeaconRegion(uuid: UUID(uuidString: beacon.key)!, identifier: beacon.value)
            locationManager?.startMonitoring(for: beaconRegion)
            locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        }
    }
    
    func update(distance: CLProximity, beaconID: String? = nil) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                self.distanceReadingLabel.text = "UNKNOWN\n"
                
            case .far:
                self.view.backgroundColor = UIColor.blue
                self.distanceReadingLabel.text = "FAR\n" + self.beacons[beaconID!]!
                self.showBeaconDetectedAlert()
                
            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceReadingLabel.text = "NEAR\n" + self.beacons[beaconID!]!
                self.showBeaconDetectedAlert()
                
            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceReadingLabel.text = "RIGHT HERE\n" + self.beacons[beaconID!]!
                self.showBeaconDetectedAlert()
                
            @unknown default:
                self.view.backgroundColor = .black
                self.distanceReadingLabel.text = "WHOA!"
            }
        }
    }
    
    // Challenge #1
    private func showBeaconDetectedAlert() {
        // Just show this alert once
        if beaconDetectedAlertShow == true { return }
        
        beaconDetectedAlertShow = true
        
        let ac = UIAlertController(title: "BEACON DETECTED", message: "Detected a beacon!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        ac.addAction(okAction)
        present(ac, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity, beaconID: beacon.uuid.uuidString)
        } else {
            update(distance: .unknown)
        }
    }
}
