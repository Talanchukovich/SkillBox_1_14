//
//  WeatherViewController2.swift
//  homeWork12
//
//  Created by Андрей Таланчук on 20.01.2021.
//

import UIKit
import CoreData

class WeatherViewController2: UIViewController {
    

    @IBOutlet weak var dayWeather2CollectionView: UICollectionView!
 
    @IBOutlet weak var dayWeather2TableView: UITableView!
    
    let loader = WeatherLoader2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayWeather2CollectionView.delegate = self
        self.dayWeather2CollectionView.dataSource = self
        self.dayWeather2TableView.dataSource = self
        getData()
        createData()
        DispatchQueue.main.async {
            self.dayWeather2TableView.reloadData()
            self.dayWeather2CollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
        DispatchQueue.main.async {
            self.dayWeather2TableView.reloadData()
            self.dayWeather2CollectionView.reloadData()
        }

    }

    // Core Data

        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        var weatherModels = [Weather]()
        var currentConditionModels = [CurrentCondition]()
        var requestModels = [Request]()
        


        func getData() {
            weatherModels = try! container.viewContext.fetch(Weather.fetchRequest())
            currentConditionModels = try! container.viewContext.fetch(CurrentCondition.fetchRequest())
            requestModels = try! container.viewContext.fetch(Request.fetchRequest())
        }

        func createData() {
            let request1 = Request(context: container.viewContext)
            let currentCondition1 = CurrentCondition(context: container.viewContext)
            let weather1 = Weather(context: container.viewContext)
            
            loader.dayWeather2 {request, currentCondition, weather in
                
                for (k, v) in request.enumerated() {
                    request1.query = v.query
                    self.requestModels[k].query = v.query
                    print(self.requestModels)
                    do {
                        try self.container.viewContext.save()
                        self.getData()
                    } catch {}
                }
            
                for (_, v) in currentCondition.enumerated() {
                    currentCondition1.feelsLikeC = v.feelsLikeC
                    currentCondition1.tempC = v.tempC
                    self.currentConditionModels.append(currentCondition1)
                    do {
                        try self.container.viewContext.save()
                        self.getData()
                    } catch {}
                }
                
                
                for (k, v) in weather.enumerated() {
                    
                   
                    func cr (i: Int) {
                    weather1.date = v.date
                    weather1.maxtempC = v.maxtempC
                    weather1.mintempC = v.mintempC

                    self.weatherModels.append(weather1)
                    }

                    for i in 0...weather.count {
                        cr(i: i)

                    }
                        DispatchQueue.main.async {
                            self.dayWeather2TableView.reloadData()
                            self.dayWeather2CollectionView.reloadData()
                        }
    
                    self.weatherModels[k].date = v.date
                    self.weatherModels[k].maxtempC = v.maxtempC
                    self.weatherModels[k].mintempC = v.mintempC
                    print("TTTTT \n \(self.weatherModels.count)")
                    print("WWWWW \n \(weather.count)")
                
                    
                    do {
                        try self.container.viewContext.save()
                        self.getData()
                    } catch {}
                }
            }
            do {
                try container.viewContext.save()
                getData()
            } catch {}
            
}
    
    
    
}

extension WeatherViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requestModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dayCell2 = dayWeather2CollectionView.dequeueReusableCell(withReuseIdentifier: "DayCell2", for: indexPath) as! DayCell2
        let cellRequest = requestModels[indexPath.item]
        let cellcurrentCondition = currentConditionModels[indexPath.item]
        let cellweather = weatherModels[indexPath.item]
        dayCell2.nameLabel2.text = cellRequest.query
        dayCell2.tempLabel2.text = cellcurrentCondition.tempC
        //dayCell2.descriptionLabel2.text = cellcurrentCondition.langRu[indexPath.row].value
        dayCell2.feelsLikeLabel2.text = "Ощущается как \(cellcurrentCondition.feelsLikeC ?? "")º"
        dayCell2.minMaxTempLabel2.text = "Макс. \(cellweather.maxtempC ?? "")º мин. \(cellweather.mintempC ?? "")º"
        return dayCell2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  dayWeather2CollectionView.bounds.size.width
        let height = dayWeather2CollectionView.bounds.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension WeatherViewController2: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(weatherModels.count)
        return weatherModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let daysCell2 = dayWeather2TableView.dequeueReusableCell(withIdentifier: "DaysCell2", for: indexPath) as! DaysCell2
        let weatherCell = weatherModels[indexPath.row]
        daysCell2.temp_minLabel2.text = weatherCell.mintempC ?? "" + "º"
        daysCell2.temp_maxLabel2.text = weatherCell.maxtempC ?? "" + "º"
        daysCell2.dateLabel2.text = dateFormatter(date: weatherCell.date ?? "").replacingOccurrences(of: ", ", with: ", \n").firstUppercased.replacingOccurrences(of: "2021", with: "").replacingOccurrences(of: "г.", with: "")
        return daysCell2
    }
}

extension WeatherViewController2{
    
    func dateFormatter(date: String) -> String{
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd"
        guard let date1 = dateFormater.date(from: date) else {return ""}
        
        let dateFormatter1 = DateFormatter()
        let rus = Locale(identifier: "ru_RU")
        dateFormatter1.dateFormat = "dd-MM"
        dateFormatter1.dateStyle = .full
        dateFormatter1.locale = rus
        let returnDate = dateFormatter1.string(from: date1 as Date)
        return returnDate
    }
}
extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}

