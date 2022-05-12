//
//  ViewController.swift
//  Project16
//
//  Created by John Salvador on 5/12/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Stored Properties
    let chooseMapTypeButton = UIButton(type: .system)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        style()
        layout()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        let manila = Capital(title: "Manila", coordinate: CLLocationCoordinate2D(latitude: 14.599512, longitude: 120.984222), info: "Capital of Fun")
        let cebu = Capital(title: "Cebu", coordinate: CLLocationCoordinate2D(latitude: 10.3789257, longitude: 123.7762547), info: "Cebu, where the heart sings")
        
        mapView.addAnnotations([manila, cebu, london, oslo, paris, rome, washington])
    }
}

// MARK: -
extension ViewController {
    func style() {
        chooseMapTypeButton.translatesAutoresizingMaskIntoConstraints = false
        chooseMapTypeButton.configuration = .filled()
        chooseMapTypeButton.setTitle("Choose Map Type", for: [])
        chooseMapTypeButton.addTarget(self, action: #selector(chooseMapType), for: .primaryActionTriggered)
    }
    
    func layout() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: chooseMapTypeButton)
    }
}

// MARK: - Methods
extension ViewController {
    @objc private func chooseMapType() {
        let actionSheet = UIAlertController(title: "Choose Map Type", message: nil, preferredStyle: .actionSheet)
        
        let standard = UIAlertAction(title: "Standard", style: .default) { [weak self] _ in
            self?.mapView.mapType = .standard
        }
        
        let satellite = UIAlertAction(title: "Satellite", style: .default) { [weak self] _ in
            self?.mapView.mapType = .satellite
        }
        
        let hybrid = UIAlertAction(title: "Hybrid", style: .default) { [weak self] _ in
            self?.mapView.mapType = .hybrid
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(standard)
        actionSheet.addAction(satellite)
        actionSheet.addAction(hybrid)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
}

// MARK: - Map View Delegate
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
       
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
            
            // Challenge #1 - This will only change the color to `Brown` once the view is reused in the MapView
            if let pinView = annotationView as? MKPinAnnotationView {
                pinView.pinTintColor = .brown
            }
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "DetailViewController", creator: { coder -> DetailViewController? in
            DetailViewController(coder: coder, capital: capital.title ?? "")
        })
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

