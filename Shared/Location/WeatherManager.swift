//
//  WeatherManager.swift
//  MyWeatherApp (iOS)
//
//  Created by Yasmine Salim on 2022-09-06.
//


// MY API = 4016fdbdcf3d690de7a132307dbfb707

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=4016fdbdcf3d690de7a132307dbfb707&units=metric")
        else { fatalError("Missing URL") }
        
        let URLRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("ERROR 0456: fetching weather data failed")}
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
        
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var humidity: Double
        var pressure: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
    var pressures: Double { return pressure }
}
