//
//  ConfirmationSheetView.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/7.
//

import SwiftUI

struct ConfirmationSheetView: View {
    @Environment(\.dismiss) var dismiss

    var businessName: String
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea()
            VStack{
                Spacer()
                Text("Congratulations!")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("")
                Text("You have successfully made an reservation at")
                    .foregroundColor(Color.white)
                Text("\(businessName)")
                    .foregroundColor(Color.white)
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Done")
                        .frame(width: 200, height:60)
                        .foregroundColor(Color.green)
                        .background(Capsule().fill(Color.white))
                }
            }
        }
    }
}

struct ConfirmationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationSheetView(businessName:"Spudnuts Donuts")
    }
}
