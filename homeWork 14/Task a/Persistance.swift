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
    private let weather = "weather"
    
    var userFirstName: String? {
        set {UserDefaults.standard.set(newValue, forKey: firstNameKey)}
        get {return UserDefaults.standard.string(forKey: firstNameKey)}
    }
    
    var userSecondName: String? {
        set {UserDefaults.standard.set(newValue, forKey: secondNameKey)}
        get {return UserDefaults.standard.string(forKey: secondNameKey)}
    }
    
//    var savedWeather1: [Weather] {
//        set {UserDefaults.standard.setValue(try! JSONEncoder().encode(newValue), forKey: weather)}
//        get {try! JSONDecoder().decode([Weather].self, from: UserDefaults.standard.data(forKey: weather)!)}
//    }
//    
//    
//    var savedWeather: [Weather] = []
//    
//    func saveWeather(weatherData: [Weather]){
//        let placesData = try! JSONEncoder().encode(weatherData)
//        if placesData.isEmpty == false {
//        UserDefaults.standard.setValue(placesData, forKey: weather)
//        }
//    }
//    
//    func loadWeather() {
//        let placesData = UserDefaults.standard.data(forKey: weather)
//        let weather: [Weather] = try! JSONDecoder().decode([Weather].self, from: placesData!)
//        self.savedWeather = weather
//    }
    
}

