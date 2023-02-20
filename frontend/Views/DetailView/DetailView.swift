//
//  DetailView.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI

struct DetailView: View {
    @StateObject var detailViewModel = DetailViewModel()
    @EnvironmentObject var reservationViewModel: ReservationViewModel

    var businessId = ""
    
    var body: some View {
        TabView{
            if detailViewModel.detailData.id != ""{
                InfoView()
                    .environmentObject(reservationViewModel)
                    .tabItem{
                        Label("Business Detail", systemImage: "text.bubble.fill")
                    }
                MapView(place: IdentifiablePlace(lat: Double(detailViewModel.detailData.coordinates.latitude)!, long: Double(detailViewModel.detailData.coordinates.longitude)!))
                    .tabItem{
                        Label("Map Location", systemImage: "location.fill")
                    }
                ReviewView()
                    .tabItem{
                        Label("Reviews", systemImage: "message.fill")
                    }
            } else {
                ProgressView()
            }
        }
        .environmentObject(detailViewModel)
        .onAppear() {
            Task{
                try await detailViewModel.SearchDetail(id:businessId)
            }
        }
        

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
