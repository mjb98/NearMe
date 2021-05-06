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
        
        let isLocationUnavaiable = Binding<Bool>(
            get: { self.viewModel.userMustGrantLocationPermision },
            set: {_ in }
               )
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
        .onAppear {
            
        }
        .alert(isPresented: isLocationUnavaiable, content: {
            Alert(
                title: Text("We need your location, please go to setting and grant location service permision"),
              
                primaryButton: .default(Text("Go to Setting")) {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                return
                            }
                    UIApplication.shared.open(settingsUrl, completionHandler: { _ in
                               
                               })
                }, secondaryButton: .destructive(Text("Exit"), action: {
                    exit(0)
                })
                
            )
        })
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
