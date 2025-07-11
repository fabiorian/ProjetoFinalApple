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

    var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)

        let initialLocation = CLLocation(latitude: -3.71722, longitude: -38.54333)
        let regionRadius: CLLocationDistance = 11000
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)

        let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: coordinateRegion)
        mapView.setCameraBoundary(cameraBoundary, animated: true)

        let zoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 1000, maxCenterCoordinateDistance: 20000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }



    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

    }
}

struct MapViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}
