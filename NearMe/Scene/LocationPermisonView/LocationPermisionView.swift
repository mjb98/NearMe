//
//  LocationPermisionView.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/21/1400 AP.
//

import SwiftUI

struct LocationPermisionView: View {
    @ObservedObject var viewModel: LocationPermsionViewModel
    
    var body: some View {
        NavigationView {
            
            let isLocationFetched = Binding<Bool>(
                get: { self.viewModel.currentLocation != nil },
                set: {_ in }
            )
            let isErrorOccured = Binding<Bool>(
                get: { self.viewModel.locationError != nil },
                set: {_ in }
            )
            VStack {
                if isLocationFetched.wrappedValue {
                    NavigationLink(
                    destination: VenuesListView(viewModel: .init(userLocation: viewModel.currentLocation!)).navigationBarHidden(true),
                    isActive: isLocationFetched,
                    label: {
                        EmptyView()
                       
                    })
                    
               
                } else {
                    VStack {
                        ProgressView()
                    }.offset(y: -50)
                }
            }
            .onAppear {
                viewModel.fetchUserLocation()
            }
            .alert(isPresented: isErrorOccured, content: {
                showAlert()
        })
                
                
        }.navigationBarHidden(true)
    }
    
    
    init(viewModel: LocationPermsionViewModel = .init()) {
        self.viewModel = viewModel
    }
    
    private func showAlert() -> Alert {
        let alertTitle = viewModel.locationError == .userDenied ? "We need your location, please go to setting and grant location service permision" : "Cannot Fetch location, please try again"
        let primartTitle = viewModel.locationError == .error ? "Retry" : "Go to Setting"
        let primaryButton = Alert.Button.default(Text(primartTitle)) {
            if viewModel.locationError == .error {
                viewModel.retryFetchingLocation()
            } else {
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                UIApplication.shared.open(settingsUrl, completionHandler: { _ in
                    
                })
            }
        }
        
        return  Alert(title: Text(alertTitle), message: nil, primaryButton: primaryButton, secondaryButton: .destructive(Text("exit"), action: {
            exit(0)
        }))
        
    }
}

struct LocationPermisionView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermisionView(viewModel: .init(locationFethcer: .init()))
    }
}
