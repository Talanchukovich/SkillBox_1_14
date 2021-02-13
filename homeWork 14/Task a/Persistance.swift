//
//  Persistance.swift
//  homeWork 14
//
//  Created by Андрей Таланчук on 30.01.2021.
//

import Foundation

class Persistance {
    
    static let persistanse = Persistance()
    private let firstNameKey = "firstNameKey"
    private let secondNameKey = "secondNameKey"
   
    
    var userFirstName: String? {
        set {UserDefaults.standard.set(newValue, forKey: firstNameKey)}
        get {return UserDefaults.standard.string(forKey: firstNameKey)}
    }
    
    var userSecondName: String? {
        set {UserDefaults.standard.set(newValue, forKey: secondNameKey)}
        get {return UserDefaults.standard.string(forKey: secondNameKey)}
    }
    

    
    
    private let weatherKey = "weather"
    private let requestKey = "request"
    private let currentConditionKey = "currentCondition"

    var savedRequest: [Request1] = []
    var savedCurrentCondition: [CurrentCondition1] = []
    var savedWeather: [Weather1] = []


    func saveWeather(request: [Request1], currentCondition: [CurrentCondition1], weather: [Weather1]){

        let requestData = try! JSONEncoder().encode(request)
        let currentConditionData = try! JSONEncoder().encode(currentCondition)
        let weatherData = try! JSONEncoder().encode(weather)
        UserDefaults.standard.setValue(requestData, forKey: requestKey)
        UserDefaults.standard.setValue(currentConditionData, forKey: currentConditionKey)
        UserDefaults.standard.setValue(weatherData, forKey: weatherKey)

    }

    func loadWeather() {

        guard let requestData = UserDefaults.standard.data(forKey: requestKey) else {return}
        let request: [Request1] = try! JSONDecoder().decode([Request1].self, from: requestData)
        self.savedRequest = request

        guard let currentConditionData = UserDefaults.standard.data(forKey: currentConditionKey) else {return}
        let currentCondition = try! JSONDecoder().decode([CurrentCondition1].self, from: currentConditionData)
        self.savedCurrentCondition = currentCondition

        guard let weatherData = UserDefaults.standard.data(forKey: weatherKey)else {return}
        let weather = try! JSONDecoder().decode([Weather1].self, from: weatherData)
        self.savedWeather = weather
    }
    
}

