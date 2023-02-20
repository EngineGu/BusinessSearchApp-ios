//
//  BusinessList.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI

struct BusinessList: View {
    @EnvironmentObject var businessViewModel: BusinessViewModel
    @EnvironmentObject var reservationViewModel: ReservationViewModel

    var body: some View {
        if businessViewModel.businessesData.count > 0 {
            let count = (businessViewModel.businessesData.count+1)
            List(0..<count) { i in
                if i == 0{
                    Text("Results")
                        .font(.system(size:30))
                        .fontWeight(.bold)
                } else {
                    NavigationLink{
                        DetailView(businessId:businessViewModel.businessesData[i-1].id)
                            .environmentObject(reservationViewModel)
                    } label: {
                        BusinessRow(business: businessViewModel.businessesData[i-1])
                    }
                }
            }
        } else {
            List{
                Text("Results")
                    .font(.system(size:30))
                    .fontWeight(.bold)
                if businessViewModel.isSubmitButtonClicked && !businessViewModel.isBusinessSearched{
                    HStack{
                        Spacer()
                        ProgressView("Please wait...")
                        Spacer()
                    }
                }
                if businessViewModel.isSubmitButtonClicked && businessViewModel.isBusinessSearched{
                    Text("No result available")
                        .foregroundColor(Color.red)
                }
            }
        }

    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
