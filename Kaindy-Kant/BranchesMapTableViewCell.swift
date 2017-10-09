//
//  BranchesMapTableViewCell.swift
//  Kaindy-Kant
//
//  Created by Niko on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import MapKit

class BranchesMapTableViewCell: UITableViewCell, MKMapViewDelegate, CLLocationManagerDelegate  {
    
    // var loc: [Location] = []
    //var titles: [String] = []
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 500
    var points = [MKPointAnnotation]()
    
    func setMapMarkers(loc: [Location], titles: [String]) {
        var locationOfBishkek = CLLocation(latitude: 42.874722, longitude: 74.612222)
        var count = 0
        mapView.showsUserLocation = true
        
        for item in loc {
            let point = MKPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: (item.latitude), longitude: (item.longitude))
            point.title = "Адрес:"
            point.subtitle = titles[count]
            mapView.addAnnotation(point)
            if count == 0 {
                locationOfBishkek = CLLocation(latitude: item.latitude, longitude: item.longitude)
            }
            count += 1
        }
        
        mapView.delegate = self
        centerMapOnLocation(location: locationOfBishkek)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
}
