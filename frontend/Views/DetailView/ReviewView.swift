//
//  ReviewView.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI

struct ReviewView: View {
    @EnvironmentObject var detailViewModel: DetailViewModel
    @State var ReviewList = [Review]()

    var body: some View {
        VStack{
            if ReviewList.count > 0{
                List(ReviewList,id:\.self){ review in
                    ReviewRow(review: review)
                }
                .offset(y:-20)
                .padding(.top,-20)
            } else {
                ProgressView()
            }
        }
        .onAppear{
            Task{
                ReviewList = try await ReviewViewModel().SearchReviews(id: detailViewModel.detailData.id)
            }
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
