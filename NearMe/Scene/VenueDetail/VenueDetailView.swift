//
//  VenueDetailView.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/21/1400 AP.
//

import SwiftUI

struct VenueDetailView: View {
  @ObservedObject var viewModel: VenueDetailViewModel

    var body: some View {
        let venue = viewModel.venue
        ScrollView {
            MapView(location: venue.location.coordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: min(UIScreen.main.bounds.height/3, 300))

            CircleImage(image: .init("placeholder"))
                .offset(y: -125)
                .padding(.bottom, -130)
                
                

            VStack(alignment: .leading) {
                Text(venue.name)
                    .font(.title)

                HStack {
                    Text(venue.location.address ?? "")
                    Spacer()
                    Text(venue.location.state ?? "")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \(venue.name)")
                    .font(.title2)
                Text(venue.description ?? "")
            }
            .padding()
        }
        .navigationTitle(venue.name)
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            viewModel.getVenueDetail()
        }
    }
}


