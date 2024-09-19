//
//  SavePhotoButton.swift
//  SwiftUI_Photos-Concurrency
//
//  Created by Mradul Kumar on 19/09/24.
//

import SwiftUI

struct SavePhotoButton: View {
    var photo: SpacePhoto
    @State private var isSaving = false

    var body: some View {
        Button {
            Task {
                isSaving = true
                await photo.save()
                isSaving = false
            }
        } label: {
            Text("Save")
                .opacity(isSaving ? 0 : 1)
                .overlay {
                    if isSaving {
                        ProgressView()
                    }
                }
        }
        .disabled(isSaving)
        .buttonStyle(.bordered)
    }
}
