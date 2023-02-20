//
//  DetailImage.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/6.
//

import SwiftUI

struct DetailImage: View {
    let photoLink: String
    var body: some View {
        AsyncImage(
            url: URL(string: photoLink),
            content: { image in
                image.resizable()
                    .aspectRatio(1.43,contentMode: .fit)
                     .frame(maxWidth: 600, maxHeight: 420,alignment: .center)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}

struct DetailImage_Previews: PreviewProvider {
    static var previews: some View {
        DetailImage(photoLink: sampleBusinessDetail.photoLinks[0])
    }
}
