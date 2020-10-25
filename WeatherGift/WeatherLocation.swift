//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Marissa D'Antonio on 10/11/20.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData() {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("We are accessing the url")
        
        guard let url = URL(string: urlString) else {
            print("Error: could not create a url")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
            } catch {
                print("json error")
            }
        }
        task.resume()
    }
}
