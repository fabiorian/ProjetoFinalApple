import UIKit
import MapKit
import CoreLocation
import SwiftUI

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {


    //Definindo variáveis
    var DHonClick: ((DonationsHouse) -> Void)?
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var mapType: MKMapType = .mutedStandard{
        didSet {
            if mapView != nil {
                mapView.mapType = mapType
            }
        }
    }

    var currentLocation: CLLocationCoordinate2D?
    var donationHouse: [DonationsHouse] = []

    //Chamando quando carregado
    override func viewDidLoad() {
        super.viewDidLoad()
        testing()

        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        mapView.mapType = mapType
        mapView.pointOfInterestFilter = .excludingAll

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        mapView.mapType = mapType
        mapView.pointOfInterestFilter = .excludingAll

        mapView.overrideUserInterfaceStyle = .dark


        ///Definindo locais limite do mapa (local inicial, zoom e raio do mapa)

        let initialLocation = CLLocation(latitude: -3.71722, longitude: -38.54333)
        let regionRadius: CLLocationDistance = 11000
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)

        let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: coordinateRegion)
        mapView.setCameraBoundary(cameraBoundary, animated: true)

        let zoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 10000, maxCenterCoordinateDistance: 30000)
        mapView.setCameraZoomRange(zoomRange, animated: true)



        addAnnotations()

        currentLocation = CLLocationCoordinate2D(latitude: -3.8319, longitude: -38.5267)

    }
    func  showRoute(to destinationCoordinate: CLLocationCoordinate2D){
        guard let userCoordinate = currentLocation else {
            print("Localização atual não dísponivel")
            return
        }

        let sourcePlacemark = MKPlacemark(coordinate: userCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self else {return}
            if let error = error {
                print("Erro ao calcular rota: \(error.localizedDescription)")
                return
            }

            guard let route = response?.routes.first else {
                print("Nenhuma rota encontrada")
                return
            }

            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 20), animated: true)
        }
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
    func locationManagerAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Localização negada ou restrita.")
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        print("Localização atual: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro ao obter localização: \(error.localizedDescription)")
    }


    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 4.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    


    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        if let selectedHouse = donationHouse.first(where: {
            $0.latitude == annotation.coordinate.latitude &&
            $0.longitude == annotation.coordinate.longitude
        }) {
            DHonClick?(selectedHouse)

            if let userLocation = currentLocation {
                showRoute(to: annotation.coordinate)
            } else {
                print("Localização não disponível")
            }
        }
    }



    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Evita customizar o ponto de localização do usuário
        if annotation is MKUserLocation {
            return nil
        }

        let identifier = "DonationHousePin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            // Cores personalizadas
            annotationView?.markerTintColor = UIColor(named: "SaffronYellow") ?? UIColor.systemYellow // Amarelo do app
            annotationView?.glyphTintColor = .black // Ícone ou texto preto
            

            // Botão de info opcional
            let rightButton = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = rightButton
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
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
