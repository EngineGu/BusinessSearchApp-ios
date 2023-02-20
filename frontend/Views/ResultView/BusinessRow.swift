//
//  BusinessRow.swift
//  YelpApp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI

struct BusinessRow: View {
    var business: Business
    var body: some View {
        HStack{
            Text(String(business.index))
            Spacer()
            ResultImage(imageUrl: business.imageUrl)
            Spacer()
            Text(business.name)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 120)
            Spacer()
            Text(String(business.rating))
                .fontWeight(.bold)
            Spacer()
            Text(String(Int(business.distance)))
                .fontWeight(.bold)
        }
        .padding()
    }
}

struct BusinessRow_Previews: PreviewProvider {
    static var previews: some View {
        BusinessRow(business:sampleBusinesses[4])
    }
}
