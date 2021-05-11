//
//  ImageLoader.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/22/1400 AP.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    private var cancellable: AnyCancellable?
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        isLoading = true
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] in
                self?.isLoading = false
                self?.image = $0
                
            }
    }
    
    func cancel() {
        self.isLoading = false
        cancellable?.cancel()
    }
}
