//
//  WeatherStruct.swift
//  homeWork12
//
//  Created by Андрей Таланчук on 20.01.2021.
//

import Foundation

struct WeatherStruct: Codable {
    let data: DataClass2
}

struct DataClass2: Codable {
    let request: [Request]
    let currentCondition: [CurrentCondition]
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case request
        case currentCondition = "current_condition"
        case weather
    }
}

struct CurrentCondition: Codable {
    let observationTime, tempC: String
    let weatherIconURL, langRu: [LangRu]
    let feelsLikeC: String

    enum CodingKeys: String, CodingKey {
        case observationTime = "observation_time"
        case tempC = "temp_C"
        case weatherIconURL = "weatherIconUrl"
        case langRu = "lang_ru"
        case feelsLikeC = "FeelsLikeC"
    }
}

struct LangRu: Codable {
    let value: String
}

struct Request: Codable {
    let query: String
}

struct Weather: Codable {
    let date: String
    let maxtempC, mintempC: String

}
