//
//  MapViewController.swift
//  FavoritePlace_VijayBharathReddy_C0872418
//
//  Created by Vijay Bharath Reddy Challa on 2023-01-24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var text: String?
    let addressString = UITextField.text
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        
        print("hello")
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            
            
            mapView.addAnnotation(annotation)
            let x: CLLocation = CLLocation(latitude: userLocation.latitude,longitude: userLocation.longitude)
            CLGeocoder().reverseGeocodeLocation(x){(Placemark,error) in
                if (error != nil){
                    
                    
                }
                else{
                    if let Placemark = Placemark?[0]{
                        var a = " "
                        if  Placemark.name != nil{
                            a += Placemark.name!
                            annotation.title = a
                        }}}}
            
            
            addSingletap()
            
            
         
            }
            
        }
    //geting location coodinates from search bar
    func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!

                    completionHandler(location.coordinate, nil)
                    return
                    print(location.coordinate)
                }
            }

            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
            
        }
    }
    
    func addSingletap(){
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        singleTap.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(singleTap)
        
       
    }
    @objc func dropPin(sender: UITapGestureRecognizer){
         let touchPoint = sender.location(in: mapView)
        let annotation1 = MKPointAnnotation()
      
         let coordinate1 = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let loc: CLLocation = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        CLGeocoder().reverseGeocodeLocation(loc){(Placemark,error) in
            if (error != nil){
                
                
            }
            else{
                if let Placemark = Placemark?[0]{
                    var address = " "
                    if  Placemark.name != nil{
                        address += Placemark.name!
                        
                       // print(address)
                       // print("hh")
                        self.text == address
                      
                        
                       
                   
                }
                    
                    annotation1.coordinate = coordinate1
                    annotation1.title = address
                    self.mapView.addAnnotation(annotation1)
                    
                    
                }
            }
            
        }
        
        
        
    }
    
    
    @IBAction func searchButon(_ sender: Any)  {
        let searchLocation = text
      
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        // Create a variable to store the name the user entered on textField
        let Name = text
            
        // Create a new variable to store the instance of the SecondViewController
        // set the variable from the SecondViewController that will receive the data
        let destinationVC = segue.destination as! ViewController
        destinationVC.Name = text ?? "hello"
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
