//
//  ViewController.swift
//  Map & Cities
//
//  Created by Olzhas Suleimenov on 20.08.2022.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
            
        // These Capital objects conform to the MKAnnotation protocol, which means we can send it to map view for display using the addAnnotation() method.
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(selectMapType))
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // if the annotation isn't from a capital city, it must return nil so iOS uses a default view
        guard annotation is Capital else { return nil }
        
        // Define a reuse identifier. This is a string that will be used to ensure we reuse annotation views as much as possible.
        let identifier = "Capital"
        
        // Try to dequeue an annotation view from the map view's pool of unused views.
        // So we will get one if it exists if there is one in reused queue. Otherwise we will get back nil in which case we need to create annotationView by hand
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        annotationView?.pinTintColor = .red
        
        // If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name.
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .red
            
            // Create a new UIButton using the built-in .detailDisclosure type. This is a small blue "i" symbol with a circle around it.
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // If it can reuse a view, update that view to use a different annotation.
            // if we have existing annotationView in a dequeue queue go ahead and use it straight awasy with our new annotation
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    // When this method is called, you'll be told what map view sent it (we only have one, so that's easy enough), what annotation view the button came from (this is useful), as well as the button that was tapped.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.addAction(UIAlertAction(title: "Wikipedia details", style: .default, handler: { [weak self] _ in
            let vc = CityDetailsWebViewViewController()
            
            switch capital.title {
            case "London":
                vc.city = .London
            case "Oslo":
                vc.city = .Oslo
            case "Paris":
                vc.city = .Paris
            case "Rome":
                vc.city = .Rome
            case "Washington DC":
                vc.city = .Washington
            case .none:
                vc.city = .London
            case .some(_):
                vc.city = .London
            }
    
            self?.navigationController?.pushViewController(vc, animated: true)
        }))
        
        present(ac, animated: true)
    }
    
    @objc func selectMapType() {
        let ac = UIAlertController(title: "Select Map Type", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Satelite", style: .default, handler: changeMapType(action:)))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: changeMapType(action:)))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: changeMapType(action:)))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    private func changeMapType(action: UIAlertAction) {
        var mapType: MKMapType
        switch action.title {
        case "Satelite":
            mapType = .satellite
        case "Hybrid":
            mapType = .hybrid
        case "Standard":
            mapType = .standard
        default:
            mapType = .standard
        }

        mapView.mapType = mapType
    }
}

