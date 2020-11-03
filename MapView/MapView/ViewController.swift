//
//  ViewController.swift
//  MapView
//
//  Created by Tony Jung on 2020/10/27.
//  Copyright © 2020 com.doyeon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
 
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    var currentLocationStr = "Current location"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setStartingPosition()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isLocationServiceEnabled()
    }
    
    
    func isLocationServiceEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            checkAuthorizationStatus()
        }
        else{
            displayAlert(isServiceEnabled: true)
        }
    }
    
    func checkAuthorizationStatus(){
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
        else if status == .restricted || status == .denied {
            displayAlert(isServiceEnabled: false)
        }
        else if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        }
        
    }
    
    func displayAlert(isServiceEnabled:Bool){
        let serviceEnableMessage = "Location services must to be enabled to use this awesome app feature. You can enable location services in your settings."
        let authorizationStatusMessage = "This awesome app needs authorization to do some cool stuff with the map"
        
        let message = isServiceEnabled ? serviceEnableMessage : authorizationStatusMessage
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        //create ok button
        let acceptAction = UIAlertAction(title: "OK", style: .default)
        
        //add ok button to alert
        alert.addAction(acceptAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
//   func setStartingPosition(){
//
//        let radius: CLLocationDistance = 2000
//        let currentLat = (locationManager.location?.coordinate.longitude)!
//        let currentLong = (locationManager.location?.coordinate.latitude)!
//    print(currentLong)
//    print(currentLat)
//
//    let startingLocation = CLLocation(latitude: currentLat, longitude: currentLong)
//
//       let position =  MKCoordinateRegion(center: startingLocation.coordinate,
//                                              latitudinalMeters: radius,
//                                              longitudinalMeters: radius)
//
//       mapView.setRegion(position, animated: true)
//   }

}

