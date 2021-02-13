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
    let request: [Request1]
    let currentCondition: [CurrentCondition1]
    let weather: [Weather1]

    enum CodingKeys: String, CodingKey {
        case request
        case currentCondition = "current_condition"
        case weather
    }
}

struct CurrentCondition1: Codable {
    let tempC: String
    let langRu: [LangRu1]
    let feelsLikeC: String

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_C"
        case langRu = "lang_ru"
        case feelsLikeC = "FeelsLikeC"
    }
}

struct LangRu1: Codable {
    let value: String
}

struct Request1: Codable {
    let query: String
}

struct Weather1: Codable {
    let date: String
    let maxtempC, mintempC: String

}
