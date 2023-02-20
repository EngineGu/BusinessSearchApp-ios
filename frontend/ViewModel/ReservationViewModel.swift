//
//  ReservationViewModel.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/7.
//

import Foundation

class ReservationViewModel: ObservableObject {
    @Published var reservationsList = [Reservation]()
    @Published var idList = [String]()
    
    func getReservationList() {
        if let storedReseravtionsData = UserDefaults.standard.object(forKey: "reservations") {
            do{
                //update reservationList
                let reservationListData = try JSONDecoder().decode([Reservation].self, from: storedReseravtionsData as! Data)
                reservationsList = reservationListData
                //update idList
                idList = [String]()
                for (_, reservation) in reservationsList.enumerated() {
                    idList.append(reservation.id)
                }
            } catch let err {
                print(err)
            }
            
        }
        guard let _ = UserDefaults.standard.object(forKey: "reservations") else {
            reservationsList = [Reservation]()
            idList = [String]()
            return
        }
    }
    
    func setReservationList(reservation:Reservation) {
        reservationsList.append(reservation)
        idList.append(reservation.id)
        if let encoded = try? JSONEncoder().encode(reservationsList) {
            UserDefaults.standard.set(encoded, forKey: "reservations")
        }
    }
    
    func deleteReservation(reservationid:String) {
        let indexOfItem = idList.firstIndex(of: reservationid)
        idList.remove(at: indexOfItem!)
        reservationsList.remove(at: indexOfItem!)
        if let encoded = try? JSONEncoder().encode(reservationsList) {
            UserDefaults.standard.set(encoded, forKey: "reservations")
        }
    }
    
    func containsReservation(id:String)->Bool{
        return idList.contains(id)
    }
}
