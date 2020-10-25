//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Marissa D'Antonio on 10/25/20.
//

import Foundation

class WeatherDetail : WeatherLocation {
    
    struct Result: Codable {
        var timezone: String
        var current: Current
    }
    
    struct Current: Codable {
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]
    }
    
    struct Weather: Codabel {
        var description: String
        var icon: Sting
    }
    
    var timeZone = ""
    
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    
    func getData(completed: @escaping() -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("We are accessing the url")
        
        guard let url = URL(string: urlString) else {
            print("Error: could not create a url")
            completed()
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error")
            }
            
            do {
                let result = try JSONDecoder().decode(Result.self, from: data!)
                print("\(result)")
                print("The TimeZone for \(self.name) is: \(result.timezone)")
                self.timezone = result.timezone
                self.currentTime = result.current.dt
                self.temperature = Int(result.current.temp.rounded())
                self.summary = result.current.weather[0].description
                self.dailyIcon = result.current.weather[0].icon
            } catch {
                print("json error")
            }
            completed()
        }
        task.resume()
    }
}
