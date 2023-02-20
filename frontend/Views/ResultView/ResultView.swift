//
//  ResultView.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI

struct ResultView: View {
    @State var isReservationViewAvtive = false
    @StateObject var businessViewModel = BusinessViewModel()
    @StateObject var reservationViewModel = ReservationViewModel()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    SearchForm()
                    //.padding(.bottom,-20)
                }
                Section{
                    BusinessList()
                        //.padding(.top,-20)
                }
            }
            .environmentObject(businessViewModel)
            .environmentObject(reservationViewModel)
            .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(
                        destination: ReservationView()
                            .environmentObject(reservationViewModel),
                        isActive: $isReservationViewAvtive) {
                        Button(action: { isReservationViewAvtive = true }) {
                            Image(systemName: "calendar.badge.clock")
                        }
                    }
                }
            }
            .navigationTitle("Business Search")
        }
        .onAppear(){
            reservationViewModel.getReservationList()
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
