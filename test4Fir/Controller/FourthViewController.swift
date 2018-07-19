//
//  FourthViewController.swift
//  test4Fir
//
//  Created by Arinjay on 27/06/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit
import  MapKit

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}


class FourthViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    // deafult value of varibales.
    var destiLat = 31.104814
    var destiLon = 77.173403
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
//        let sourceLocation = CLLocationCoordinate2D(latitude:28.704059 , longitude: 77.102490)
//        let destinationLocation = CLLocationCoordinate2D(latitude: destiLat , longitude: destiLon)

        let sourceLocation = CLLocationCoordinate2D(latitude:39.173209  , longitude: -94.593933)
        let destinationLocation = CLLocationCoordinate2D(latitude:destiLat  , longitude: destiLon)
        
        // Setting up Custom Pins
        let sourcePin = customPin(pinTitle: "Kansas", pinSubTitle: "Must visit Once", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "Destination", pinSubTitle: "Need to reach here", location: destinationLocation)
        self.mapView.addAnnotation(sourcePin)
        self.mapView.addAnnotation(destinationPin)
        
        
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            
            let route = directionResonse.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
        self.mapView.delegate = self
    }

    // Setting up directions line
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Back Button Function
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

  
}
