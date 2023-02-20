//
//  ReservationView.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI

struct ReservationView: View {
    @EnvironmentObject var reservationViewModel: ReservationViewModel

    var body: some View {
        VStack{
                if reservationViewModel.reservationsList.count > 0{
                    List{
                        ForEach(reservationViewModel.reservationsList){ reservation in
                            HStack{
                                Text("\(reservation.name)")
                                    .frame(width: 80)
                                    .font(.system(size: 12))
                                Text("\(reservation.date)")
                                    .frame(width: 70)
                                    .font(.system(size: 12))
                                Text("\(reservation.time)")
                                    .frame(width: 40)
                                    .font(.system(size: 12))
                                Text("\(reservation.email)")
                                    .frame(width: 100)
                                    .font(.system(size: 12))
                            }
                        }
                        .onDelete(){ indexSet in
                            for index in indexSet{
                                let id = reservationViewModel.idList[index]
                                reservationViewModel.deleteReservation(reservationid: id)
                            }
                        }
                    }
                    .navigationTitle("Your Reservations")
                } else {
                    Text("No bookings found")
                        .foregroundColor(Color.red)
                        .navigationTitle("Your Reservations")
                        .navigationBarTitleDisplayMode(.large)
                }
        }
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
