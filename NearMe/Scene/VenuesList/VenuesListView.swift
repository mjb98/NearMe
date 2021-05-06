//
//  VenuesListView.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/16/1400 AP.
//

import SwiftUI

struct VenuesListView: View {
    @ObservedObject var viewModel: VenuesListViewModel
    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .navigationBarTitle("Near places")
        }
    }
    
    init(viewModel: VenuesListViewModel = VenuesListViewModel()) {
        self.viewModel = viewModel
    }
}

struct VenuesListView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesListView()
    }
}
