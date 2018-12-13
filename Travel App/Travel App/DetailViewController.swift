//
//  DetailViewController.swift
//  Travel App
//
//  Created by Milan Patel on 9/24/18.
//  Copyright © 2018 Milan Patel. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    var selectedCity:String?
    var selectedDescription:String?
    var selectedImage:String?
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var lon: UILabel!
    var selectedLat:String?
    var selectedLon:String?
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTitle.text = selectedCity
        detailDescription.text = selectedDescription
        detailImage.image = UIImage(named: selectedImage!)
        showCity()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func showMap(_ sender: Any) {
        
        switch(mapType.selectedSegmentIndex) {
        case 0:
            map.mapType = MKMapType.standard
        case 1:
            map.mapType = MKMapType.satellite
        default:
            map.mapType = MKMapType.standard
        }
        showCity()
    }
    
    func showCity () {
        let geoCoder = CLGeocoder();
        let addressString = selectedCity
        CLGeocoder().geocodeAddressString(addressString!, completionHandler:
            {(placemarks, error) in
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    self.lat.text = String(coords.latitude)
                    self.lon.text = String(coords.longitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = placemark.locality
                    ani.subtitle = placemark.subLocality
                    self.map.addAnnotation(ani)
                }
        })
    }
    
    
    @IBAction func performSearch(_ sender: Any) {
        showCity()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchField.text
        request.region = map.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name
                self.map.addAnnotation(ani)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
