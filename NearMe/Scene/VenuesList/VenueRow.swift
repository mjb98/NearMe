//
//  VenueRow.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/16/1400 AP.
//

import SwiftUI

struct VenueRow: View {
    let venue: Venue
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(venue.name).font(.title3).lineLimit(1)
                Spacer()
            }
            HStack {
                Text(venue.location?.address ?? "")
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                Spacer()
            }
        }
    }
}

struct VenueRow_Previews: PreviewProvider {
    static var previews: some View {
        VenueRow(venue: .init(id: "", name: "test", location: nil))
    }
}
