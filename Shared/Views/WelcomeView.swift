//
//  WelcomeView.swift
//  MyWeatherApp (iOS)
//
//  Created by Yasmine Salim on 2022-09-06.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager:
    LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {

                
                Spacer()
                
                
                AsyncImage(url: URL(string: "https://cdn-icons-png.flaticon.com/512/2640/2640490.png")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                } placeholder: {
                    ProgressView()
                }
                
                Spacer()
                
            // indecisive about adding text to the welcome view,
                // no text gives a cleaner look 
                
//                Text("Please share your current location")
            }
            .multilineTextAlignment(.center)

            // this is to get the users current location
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
    
            .padding()
            Spacer()
            
        }   
        .background(Color(hue: 290, saturation: 0.075, brightness: 0.075))
            .preferredColorScheme(.dark)
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
                .previewInterfaceOrientation(.portrait)
            WelcomeView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
