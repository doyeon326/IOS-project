//
//  MapViewController.swift
//  GooglePlacesSearchController_Example
//
//  Created by Tony Jung on 2020/10/09.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapCenterPinImage: UIImageView!
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
      //  mapCenterPinImage.bringSubviewToFront(mapView)
       // mapView.bringSubviewToFront(mapCenterPinImage)
    }

}

extension MapViewController: CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else{
            return
        }
        locationManager.requestLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    }
    
    func  locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    }

