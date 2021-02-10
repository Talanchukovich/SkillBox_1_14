//
//  WeatherLoader2.swift
//  homeWork12
//
//  Created by Андрей Таланчук on 20.01.2021.
//

import Foundation
import Alamofire

class WeatherLoader2 {
    
    let persistance = Persistance()
    func dayWeather2 (comletition: @escaping ([Request], [CurrentCondition], [Weather]) -> Void){
        
        let request = URLRequest(url: URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=763ccc3ca5c54dc88ea104425211801&q=moscow,ru&num_of_days=14&tp=24&format=JSON&date_format=unix&lang=ru")!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        AF.request(request).validate().responseData { response in
            switch response.result {
            case .success(let value):
                do {
                    let result = try JSONDecoder().decode(WeatherStruct.self, from: value)
                    var request: [Request] = []
                    var currentCondition: [CurrentCondition] = []
                    var weather: [Weather] = []
                    for (_, data) in result.data.request.enumerated(){
                        request.append(data)
                    }
                    for (_, data) in result.data.currentCondition.enumerated(){
                        currentCondition.append(data)
                    }
                    for (_, data) in result.data.weather.enumerated(){
                        weather.append(data)
                    }
                    weather.remove(at: 0)
                    
                    comletition(request, currentCondition, weather)
                } catch {}
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
