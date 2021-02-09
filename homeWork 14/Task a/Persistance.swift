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
}
