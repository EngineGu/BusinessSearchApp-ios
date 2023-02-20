//
//  ReservationSheetView.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/7.
//

import SwiftUI

struct ReservationSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var businessName: String
    var businessId:String
    @EnvironmentObject var reservationViewModel: ReservationViewModel
    
    @State var email: String = ""
    @State var reservationDate = Date.now
    @State var selectedHour = "10"
    @State var selectedMinute = "00"
    
    //validate email
    @State var isShowingInvalidEmailToast = false
    
    @State var isShowingConfirmationSheet = false
    //datePicker
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()

    var body: some View {
        VStack {
            Form{
                Section{
                    Text("Reservation Form")
                        .font(.system(size:30))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Section{
                    Text("\(businessName)")
                        .font(.system(size:29,weight: .medium,design: .default))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Section{
                    HStack{
                        Text("Email:")
                            .foregroundColor(.secondary)
                        TextField("",text:$email)
                    }
                    .padding(.top)
                    .padding(.bottom)
                    HStack{
                        Text("Date/Time:")
                            .foregroundColor(.secondary)
                        DatePicker("",selection: $reservationDate, in: Date.now..., displayedComponents: .date)
                        HStack{
                            Menu{
                                Picker("", selection: $selectedHour) {
                                    ForEach(["10","11","12","13","14","15","16","17"],id:\.self){ hour in
                                        Text(hour)
                                    }
                                }
                            } label: {
                                Text(selectedHour)
                                    .foregroundColor(Color.black)
                            }
                            Text(":")
                            Menu{
                                Picker("", selection: $selectedMinute) {
                                    ForEach(["00","15","30","45"],id:\.self){ minute in
                                        Text(minute)
                                    }
                                }
                            } label: {
                                Text(selectedMinute)
                                    .foregroundColor(Color.black)
                            }
                        }
                        .frame(width:80,height: 30)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(red: 0.9372, green: 0.9372, blue: 0.9372)))
                    }
                    .padding(.top)
                    .padding(.bottom)
                    Button(action: {
                        if email != "" && isValidEmail(email){
                            let dateString = dateFormatter.string(from: reservationDate)
                            let timeString = "\(selectedHour):\(selectedMinute)"
                            reservationViewModel.getReservationList()
                            let newReservation = Reservation(id: businessId, name: businessName, email: email, date: dateString, time: timeString)
                            reservationViewModel.setReservationList(reservation: newReservation)
                            isShowingConfirmationSheet = true
                        } else {
                            isShowingInvalidEmailToast = true
                        }
                    }) {
                        Text("Submit")
                            .frame(width: 120, height:45)
                            .foregroundColor(Color.white)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .sheet(isPresented: $isShowingConfirmationSheet,onDismiss: {
                        dismiss()
                    }) {
                        ConfirmationSheetView(businessName: businessName)
                        
                    }
                }
            }//form end
            .frame(maxWidth: .infinity, alignment: .center)
            .toast(isPresented: $isShowingInvalidEmailToast){
                HStack{
                        Text("Please enter a valid email.")
                        .foregroundColor(Color(.black))
                }
            }
        } // vstack end
    }
}

// validate email
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

struct ReservationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationSheetView(businessName: "Squdnuts Donuts", businessId: "hgfbnjkfthbrj")
    }
}



