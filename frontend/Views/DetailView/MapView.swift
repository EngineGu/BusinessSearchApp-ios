//
//  MapView.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI
import MapKit

struct IdentifiablePlace: Identifiable {
    let id: UUID
    var location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}


struct MapView: View {
    @EnvironmentObject var detailViewModel: DetailViewModel

    let place: IdentifiablePlace
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: Double(sampleBusinessDetail.coordinates.latitude)!, longitude: Double(sampleBusinessDetail.coordinates.longitude)!), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems:[place]){ place in
            MapMarker(coordinate: place.location,
                      tint: Color.red)
        }
        .offset(y:-20)
        .padding(.top,-20)
        .onAppear{
            region.center.latitude = Double(detailViewModel.detailData.coordinates.latitude)!
            region.center.longitude = Double(detailViewModel.detailData.coordinates.longitude)!
        }
    }

}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(place:IdentifiablePlace(lat: Double(33.0), long: Double(-118.0)))
    }
}
