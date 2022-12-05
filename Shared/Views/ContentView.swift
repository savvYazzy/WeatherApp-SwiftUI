//
//  ContentView.swift
//  Shared
//
//  Created by Yasmine Salim on 2022-09-06.
//

import SwiftUI

struct ContentView: View {
   @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await
                                weatherManager.getCurrentWeather(latitude:
                                   location.latitude, longitude:
                                    location.longitude)
                                
                            } catch {
                                print("Error 0445 cannot get weather: \(error)")
                            }
                        }
                    }
                } else {
                    if locationManager.isLoading {
                        LoadingView()
                    } else {
                        WelcomeView() .environmentObject(locationManager)
                    }
                }
            }
        
        .background(Color(hue: 290, saturation: 0.075, brightness: 0.075))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
