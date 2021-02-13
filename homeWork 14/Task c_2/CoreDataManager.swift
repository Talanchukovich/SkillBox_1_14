//
//  CoreDataManager.swift
//  homeWork 14
//
//  Created by Андрей Таланчук on 13.02.2021.
//

import Foundation
import UIKit
import CoreData


//class CoreDataManager {
//
//    let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
//    let loader = WeatherLoader2()
//    var weatherModels = [Weather]()
//    var currentConditionModels = [CurrentCondition]()
//    var requestModels = [Request]()
//    
//
//
//    func getData() {
//        weatherModels = try! container.viewContext.fetch(Weather.fetchRequest())
//        currentConditionModels = try! container.viewContext.fetch(CurrentCondition.fetchRequest())
//        requestModels = try! container.viewContext.fetch(Request.fetchRequest())
//    }
//
//    func createData() {
//        let request1 = Request(context: container.viewContext)
//        let currentCondition1 = CurrentCondition(context: container.viewContext)
//        let weather1 = Weather(context: container.viewContext)
//        
//        loader.dayWeather2 {request, currentCondition, weather in
//            
//           
//           
//            for (k, v) in request.enumerated() {
//                self.container.viewContext.delete(request1)
//                request1.query = v.query
//                self.requestModels[k].query = v.query
//                print(self.requestModels)
//                do {
//                    try self.container.viewContext.save()
//                    self.getData()
//                } catch {}
//            }
//        
//            for (_, v) in currentCondition.enumerated() {
//                currentCondition1.feelsLikeC = v.feelsLikeC
//                currentCondition1.tempC = v.tempC
//                self.currentConditionModels.append(currentCondition1)
//                do {
//                    try self.container.viewContext.save()
//                    self.getData()
//                } catch {}
//            }
//            
//            for (k, v) in weather.enumerated() {
//
//                for i in 0...k {
//                    weather1.date = v.date
//                    weather1.maxtempC = v.maxtempC
//                    weather1.mintempC = v.mintempC
//                   
//                    self.weatherModels.append(weather1)
//                }
//                self.weatherModels[k].date = v.date
//                self.weatherModels[k].maxtempC = v.maxtempC
//                self.weatherModels[k].mintempC = v.mintempC
//            
//                
//                do {
//                    try self.container.viewContext.save()
//                    self.getData()
//                } catch {}
//            }
//        }
//        do {
//            try container.viewContext.save()
//            getData()
//        } catch {}
//        
//    }
//}
