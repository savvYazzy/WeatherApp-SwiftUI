//
//  WeatherView.swift
//  MyWeatherApp (iOS)
//
//  Created by Yasmine Salim on 2022-09-07.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                // get city name
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                // get today's date
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            // to make the icon dynamic it needs an if statement that indicates
                            // if the weather conditions are a specific type, display image system ""
                            
                            // get weather info
                            Image(systemName: "cloud.fill")
                                .font(.system(size: 50))
                            
                            Text("\(weather.weather[0].main)")
                        }     .position(x: 32, y: 170)
                        
                        .frame(width: 150, alignment: .leading)
                        
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 99))
                            .fontWeight(.regular)
                            .padding()
                            .position(x: -90, y: 60)
                    }
                    
                    Spacer()
                        .frame(height:  80)
                    
                    // collected my own image URL
                    
                    AsyncImage(url: URL(string: "https://www.ccianesthesia.com/wp-content/uploads/2020/05/city.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 340)
                            .position(x: 180, y: -80)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather Details")
                        .bold()
                        .padding(.bottom)
                    
                    // weather details - added the third row with 2 extra API calls
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    
                    
                    HStack {
                              WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                              Spacer()
                              WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                          }
                    
                    // added the rest of remaining API calls here

                    
                    HStack {
                              WeatherRow(logo: "stopwatch", name: "Pressure", value: (weather.main.pressure.roundDouble()))
                              Spacer()
                              WeatherRow(logo: "aqi.medium", name: "Feels Like", value: (weather.main.feelsLike.roundDouble() + ("°")))
   
                }
                    
            }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.01, saturation: 0, brightness: 0.999))
//                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 290, saturation: 0.075, brightness: 0.075))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}

