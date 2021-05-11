//
//  AsyncImage.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/22/1400 AP.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let isCircular: Bool
    
    init(url: URL, isCircular: Bool = false, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        self.isCircular = isCircular
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
           Group {
               if loader.image != nil {
                if isCircular {
                    CircleImage(image: Image(uiImage: loader.image!))
                } else {
                    Image(uiImage: loader.image!)
                }
                       
               } else {
                ZStack(alignment: .top) {
                    placeholder
                    if loader.isLoading {
                        ProgressView()
                           
                    }
                    
                }
               }
           }
       }
}
