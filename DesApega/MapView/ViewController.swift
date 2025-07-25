//
//  ViewController.swift
//  DesApega
//
//  Created by User on 11/07/25.
//

import UIKit
import MapKit
import CoreLocation
import SwiftUI

class ViewController: UIViewController, MKMapViewDelegate {


    //Definindo variáveis
    var DHonClick: ((DonationsHouse) -> Void)?
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var mapType: MKMapType = .standard{
        didSet {
            if mapView != nil {
                mapView.mapType = mapType
            }
        }
    }

    var donationHouse: [DonationsHouse] = []

    //Chamando quando carregado
    override func viewDidLoad() {
        super.viewDidLoad()
        testing()

        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.mapType = mapType
        mapView.pointOfInterestFilter = .excludingAll

        ///Definindo locais limite do mapa (local inicial, zoom e raio do mapa)

        let initialLocation = CLLocation(latitude: -3.71722, longitude: -38.54333)
        let regionRadius: CLLocationDistance = 11000
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)

        let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: coordinateRegion)
        mapView.setCameraBoundary(cameraBoundary, animated: true)

        let zoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 3000, maxCenterCoordinateDistance: 20000)
        mapView.setCameraZoomRange(zoomRange, animated: true)

        addAnnotations()
    }

    func addAnnotations() {
        for house in donationHouse {
               let annotation = MKPointAnnotation()
               annotation.title = house.name
               annotation.subtitle = house.description
               annotation.coordinate = CLLocationCoordinate2D(latitude: house.latitude, longitude: house.longitude)
               mapView.addAnnotation(annotation)
           }
       }




    func locationManagerAuthorization(_ manager: CLLocationManager){
        switch manager.authorizationStatus{
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Localização não autorizada")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError("Status de autorização desconhecido")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else{ return}
        let managerRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(managerRegion, animated: true)
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro ao tentar obter a localização: \(error.localizedDescription)")
    }

    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
    }

//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//
//    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }

              if let selectedHouse = donationHouse.first(where: {
                  $0.latitude == annotation.coordinate.latitude &&
                  $0.longitude == annotation.coordinate.longitude
              }) {
                  DHonClick?(selectedHouse)
              }
          }
    }


    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "DonationHousePin"

            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                let pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                pinView.canShowCallout = true
                pinView.markerTintColor = .systemGreen
                annotationView = pinView
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }

struct MapViewController: UIViewControllerRepresentable {
    @Binding var mapType: MKMapType
    var donationHouse: [DonationsHouse]
    var DHonClick: (DonationsHouse) -> Void

    func makeUIViewController(context: Context) -> ViewController {
        let vc = ViewController()
        vc.mapType = mapType
        vc.DHonClick = DHonClick
        vc.donationHouse = donationHouse
        return vc
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        uiViewController.mapType = mapType
    }
}
