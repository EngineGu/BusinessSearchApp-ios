//
//  ResultImage.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import SwiftUI

struct ResultImage: View {
    var imageUrl: String
    var body: some View {
        if imageUrl != "" {
            AsyncImage(
                url: URL(string: imageUrl),
                content: { image in
                    image.resizable()
                        .aspectRatio(1.0,contentMode: .fit)
                         .frame(maxWidth: 50, maxHeight: 50,alignment: .center)
                         .cornerRadius(10)
                },
                placeholder: {
                    ProgressView()
                }
            )
        } else {
            Image("")
                .aspectRatio(1.0,contentMode: .fit)
                .frame(maxWidth: 50, maxHeight: 50,alignment: .center)
                .cornerRadius(10)
        }
    }
}

struct ResultImage_Previews: PreviewProvider {
    static var previews: some View {
        ResultImage(imageUrl: "https://s3-media4.fl.yelpcdn.com/bphoto/OYRIqyjBhRPr-ZxsL7QGhQ/o.jpg")
    }
}
