//
//  VenueDetailView.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/21/1400 AP.
//

import SwiftUI

struct VenueDetailView: View {
    var venue: Venue

    var body: some View {
        ScrollView {
            MapView(coordinate: .init(latitude: venue.location!.latitude, longitude: venue.location!.longitude))
                .ignoresSafeArea(edges: .top)
                .frame(height: min(UIScreen.main.bounds.height/3, 300))

            CircleImage(image: .init("turtlerock"))
                .offset(y: -130)
                .padding(.bottom, -130)
                
                

            VStack(alignment: .leading) {
                Text(venue.name)
                    .font(.title)

                HStack {
                    Text(venue.location?.address ?? "")
                    Spacer()
                    Text(venue.location?.state ?? "")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \(venue.name)")
                    .font(.title2)
                Text(venue.location?.address ?? "")
            }
            .padding()
        }
        .navigationTitle(venue.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


