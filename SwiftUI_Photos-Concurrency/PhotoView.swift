//
//  PhotoView.swift
//  SwiftUI_Photos-Concurrency
//
//  Created by Mradul Kumar on 19/09/24.
//

import SwiftUI

struct PhotoView: View {
    var photo: SpacePhoto
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: photo.url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(minWidth: 0, minHeight: 400)
            
            HStack {
                Text(photo.title)
                Spacer()
                SavePhotoButton(photo: photo)
            }
            .padding()
            .background(.thinMaterial)
        }
        .background(.thickMaterial)
        .mask(RoundedRectangle(cornerRadius: 16))
        .padding(.bottom, 8)
    }
}
