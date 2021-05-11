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
            List {
                ForEach(viewModel.venues) { venue in
                    NavigationLink(destination: ContentView()) {
                        VenueRow(venue: venue)
                    }
                }
                if let _ = viewModel.error {
                    Button(action: {
                        self.viewModel.getVenues()
                    }, label: {
                        HStack(alignment: .center) {
                            Spacer()
                            Image("refresh").resizable().frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text("Cannot fehtch data , tap to try again").font(.caption2)
                            Spacer()
                        }.foregroundColor(.blue)
                    })
                } else {
                    
                    if viewModel.isMoreDataAvaialbe {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        .onAppear {
                            viewModel.getVenues()
                        }
                    }
                }
                
            }
            .navigationBarTitle("Near places")
        }
      
    }
    
    init(viewModel: VenuesListViewModel) {
        self.viewModel = viewModel
        
    }
}

