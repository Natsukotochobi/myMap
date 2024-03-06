//
//  MapView.swift
//  MyMap
//
//  Created by natsuko mizuno on 2024/02/27.
//

import SwiftUI
import MapKit

enum MapType {
    case standard
    case satelite
    case hybrid        //衛生写真&交通機関ラベル
}

struct MapView: UIViewRepresentable {
    //検索ワード
    let searchKey: String
    //マップ種類
    let mapType: MapType
    
    func makeUIView(context: Context) -> MKMapView {
         // MKMapViewのインスタンスを生成
         MKMapView()
     }
     
     // 表示した View が更新される度に実行
     func updateUIView(_ uiView: MKMapView, context: Context) {
         print("検索ワード：　\(searchKey)")
         
         switch mapType {
         case .standard:
             uiView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: .flat)
         case .satelite:
             uiView.preferredConfiguration = MKImageryMapConfiguration()
         case .hybrid:
             uiView.preferredConfiguration = MKHybridMapConfiguration()
         }
         
         let geocoder = CLGeocoder()
         
         geocoder.geocodeAddressString(
            searchKey,
            
            completionHandler: { (placemarks, error) in
                if let placemarks,
                   let firstPlacemark = placemarks.first,
                   let location = firstPlacemark.location {
                    
                    let targetCoordinate = location.coordinate
                    
                    print("緯度経度： \(targetCoordinate)")
                    
                    let pin = MKPointAnnotation()
                    
                    pin.coordinate = targetCoordinate
                    
                    pin.title = searchKey
                    
                    uiView.addAnnotation(pin)
                    
                    uiView.region = MKCoordinateRegion(
                        center: targetCoordinate,
                        latitudinalMeters: 500.0,
                        longitudinalMeters: 500.0
                    )
                }
                
            })
     }
}

#Preview {
    MapView(searchKey: "羽田空港", mapType: .standard)
}
