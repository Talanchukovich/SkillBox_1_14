//
//  WeatherLoader2.swift
//  homeWork12
//
//  Created by Андрей Таланчук on 20.01.2021.
//

import Foundation
import Alamofire
import CoreData

class WeatherLoader2 {
    
    func dayWeather2 (comletition: @escaping ([Request1], [CurrentCondition1], [Weather1]) -> Void){
        guard let url = URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=763ccc3ca5c54dc88ea104425211801&q=moscow,ru&num_of_days=14&tp=24&format=JSON&date_format=unix&lang=ru") else {return}
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        AF.request(request).validate().responseData { response in
            switch response.result {
            case .success(let value):
                do {
                    let result = try JSONDecoder().decode(WeatherStruct.self, from: value)
                    let request = result.data.request.map{$0}
                    let currentCondition = result.data.currentCondition.map{$0}
                    var weather = result.data.weather.map{$0}
                    weather.remove(at: 0)
                    comletition(request, currentCondition, weather)
                } catch {}
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
