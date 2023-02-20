//
//  ReviewRow.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/6.
//

import SwiftUI

struct ReviewRow: View {
    var review: Review
    var body: some View {
        VStack{
            HStack{
                Text(review.username)
                    .fontWeight(.bold)
                Spacer()
                Text("\(String(Int(review.rating)))/5")
                    .fontWeight(.bold)
            }
            .padding(.bottom,2)
            Text(review.text)
                .foregroundColor(.secondary)
                .padding(.bottom,2)
            Text(review.time_created)
        }
        .padding()
    }
}

struct ReviewRow_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRow(review: sampleReviews[0])
    }
}
