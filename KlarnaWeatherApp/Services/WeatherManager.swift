//
//  WeatherManager.swift
//  KlarnaWeatherApp
//
//  Created by Mark Labios on 11/11/19.
//  Copyright © 2019 Mark Labios. All rights reserved.
//

import Foundation

protocol WeatherDelegate {
    func weatherDidChange()
}

class WeatherManager: ObservableObject, UserLocationDelegate {
   
    let weatherURL = "https://api.darksky.net/forecast/2bb07c3bece89caf533ac9a5d23d8417/"
    let userLocation = UserLocation()
    var delegate: WeatherDelegate?
    
    @Published var weatherModel: WeatherModel = WeatherModel(objectID: "init", temperature: 0, summary: "Loading...", timezone: "Loading...")
    
    init() {
        userLocation.delegate = self
    }
    
    func fetchWeather() {
        userLocation.startUpdating()
    }
    
    func onUserLocationUpdate(latitude: Double, longitude: Double) {
        let urlString = "\(weatherURL)\(latitude),\(longitude)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.weatherModel = weather
                            self.delegate!.weatherDidChange()
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let summary = decodedData.currently.summary
            let temperature = decodedData.currently.temperature
            let timezone = formatTimezone(decodedData.timezone)
            
            let weather = WeatherModel(objectID: String(Date().timeIntervalSince1970), temperature: Int(temperature), summary: summary, timezone: timezone)
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
    
    private func formatTimezone(_ timezone: String) -> String {
        return String(timezone.split(separator: "/")[1]).replacingOccurrences(of: "_", with: " ")
    }
}
