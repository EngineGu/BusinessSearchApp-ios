//
//  InfoView.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var detailViewModel: DetailViewModel
    @EnvironmentObject var reservationViewModel: ReservationViewModel

    @Environment(\.openURL) var openURL
    
    @State var isShowingReservationSheet = false
    @State var isShowingCancelRoast = false


    var body: some View {
        VStack{
            Text(detailViewModel.detailData.name)
                .font(.system(size:30))
                .fontWeight(.bold)
                .padding(.top,5)
                .padding(.bottom,5)
                .padding(.leading)
                .padding(.trailing)
            HStack{
                VStack(alignment: .leading){
                    if detailViewModel.detailData.address != ""{
                        Text("Address")
                            .fontWeight(.bold)
                        Text(detailViewModel.detailData.address)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(height:45)
                    }
                    if detailViewModel.detailData.phoneNumber != ""{
                        Text("Phone")
                            .fontWeight(.bold)
                            .padding(.top)
                        Text(detailViewModel.detailData.phoneNumber)
                            .foregroundColor(.secondary)
                    }
                    if detailViewModel.detailData.status != ""{
                        Text("Status")
                            .fontWeight(.bold)
                            .padding(.top)
                        if detailViewModel.detailData.status == "Open Now" {
                            Text(detailViewModel.detailData.status)
                                .foregroundColor(.green)
                        } else {
                            Text(detailViewModel.detailData.status)
                                .foregroundColor(.red)
                        }
                    }
                }
                VStack(alignment: .trailing){
                    if detailViewModel.detailData.category != ""{
                        Text("Category")
                            .fontWeight(.bold)
                        Text(detailViewModel.detailData.category)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(height:45)
                    }
                    if detailViewModel.detailData.price != ""{
                        Text("Price Range")
                            .fontWeight(.bold)
                            .padding(.top)
                        Text(detailViewModel.detailData.price)
                            .foregroundColor(.secondary)
                    }
                    if detailViewModel.detailData.moreInfoLink != "" {
                        Text("Visit Yelp for more")
                            .fontWeight(.bold)
                            .padding(.top)
                        Link("Business Link", destination: URL(string: detailViewModel.detailData.moreInfoLink)!)
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            if reservationViewModel.containsReservation(id: detailViewModel.detailData.id){
                Button(action: {
                    reservationViewModel.deleteReservation(reservationid: detailViewModel.detailData.id)
                    isShowingCancelRoast = true
                }) {
                    Text("Cancel Reservation")
                        .frame(width: 220, height:45)
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.blue)))
                }
                .padding(.top)
                .padding(.bottom)
            } else {
                Button(action: {
                    isShowingReservationSheet = true
                }) {
                    Text("Reserve Now")
                        .frame(width: 120, height:45)
                        .foregroundColor(Color.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 1, green: 0.2313, blue: 0.1882)))
                }
                .padding(.top)
                .padding(.bottom)
            }
            HStack{
                Text("Share on:")
                    .fontWeight(.bold)
                Button(action: {
                    openURL(URL(string: detailViewModel.detailData.facebookLink)!)
                }) {
                    Image("facebookIcon")
                        .resizable()
                        .aspectRatio(1,contentMode: .fit)
                        .frame(maxWidth: 50, maxHeight: 50,alignment: .center)
                }
                Button(action: {
                    openURL(URL(string: detailViewModel.detailData.twitterLink)!)
                }) {
                    Image("twitterIcon")
                        .resizable()
                        .aspectRatio(1,contentMode: .fit)
                        .frame(maxWidth: 50, maxHeight: 50,alignment: .center)
                }
            }
            if detailViewModel.detailData.photoLinks.count>0{
                TabView {
                    ForEach(detailViewModel.detailData.photoLinks, id:\.self){ photoLink in
                        DetailImage(photoLink: photoLink)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .toast(isPresented: $isShowingCancelRoast) {
                    HStack{
                            Text("Your reservation is cancelled.")
                            .foregroundColor(Color.black)
                            .padding()
                    }
                }
            } else {
                TabView {
                    ForEach([0,1,2], id:\.self){ i in
                        Image("")
                            .resizable()
                            .aspectRatio(1.43,contentMode: .fit)
                            .frame(maxWidth: 600, maxHeight: 420,alignment: .center)                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .toast(isPresented: $isShowingCancelRoast) {
                    HStack{
                            Text("Your reservation is cancelled.")
                            .foregroundColor(Color.black)
                            .padding()
                    }
                }
            }
        }
        .offset(y:-20)
        .padding(.top,-20)
        .sheet(isPresented: $isShowingReservationSheet) {
            ReservationSheetView(businessName: detailViewModel.detailData.name, businessId: detailViewModel.detailData.id)
                .environmentObject(reservationViewModel)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
