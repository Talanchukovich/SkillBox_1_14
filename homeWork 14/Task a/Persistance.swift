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
    
    var savedRequest: [Request] = []
    var savedCurrentCondition: [CurrentCondition] = []
    var savedWeather: [Weather] = []
    
    
    func saveWeather(request: [Request], currentCondition: [CurrentCondition], weather: [Weather]){
       
        let requestData = try! JSONEncoder().encode(request)
        let currentConditionData = try! JSONEncoder().encode(currentCondition)
        let weatherData = try! JSONEncoder().encode(weather)
        UserDefaults.standard.setValue(requestData, forKey: requestKey)
        UserDefaults.standard.setValue(currentConditionData, forKey: currentConditionKey)
        UserDefaults.standard.setValue(weatherData, forKey: weatherKey)

    }
    
    func loadWeather() {
        
        let requestData = UserDefaults.standard.data(forKey: requestKey)
        let request: [Request] = try! JSONDecoder().decode([Request].self, from: requestData!)
        self.savedRequest = request
        
        let currentConditionData = UserDefaults.standard.data(forKey: currentConditionKey)
        let currentCondition = try! JSONDecoder().decode([CurrentCondition].self, from: currentConditionData!)
        self.savedCurrentCondition = currentCondition
        
        let weatherData = UserDefaults.standard.data(forKey: weatherKey)
        let weather = try! JSONDecoder().decode([Weather].self, from: weatherData!)
        self.savedWeather = weather
    }
    
}

