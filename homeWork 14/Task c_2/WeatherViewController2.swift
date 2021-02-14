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
        weatherModels = try! container.viewContext.fetch(Weather.fetchRequest()).sorted { previus, next in
            return previus.date ?? "" < next.date ?? ""}
        currentConditionModels = try! container.viewContext.fetch(CurrentCondition.fetchRequest())
        requestModels = try! container.viewContext.fetch(Request.fetchRequest())
    }
    
    func deleteData () {
        requestModels = try! container.viewContext.fetch(Request.fetchRequest())
        currentConditionModels = try! container.viewContext.fetch(CurrentCondition.fetchRequest())
        weatherModels = try! container.viewContext.fetch(Weather.fetchRequest())

        for request in requestModels {
            self.container.viewContext.delete(request)
        }
        for currentCondition in currentConditionModels {
            self.container.viewContext.delete(currentCondition)
        }
        for weather in weatherModels {
            self.container.viewContext.delete(weather)
        }
        do {
            try self.container.viewContext.save()
        } catch {}
    }

    func createData() {
        loader.dayWeather2 {request, currentCondition, weather in
            
            self.deleteData()
           
            let _ = request.map {
                let request = Request(context: self.container.viewContext)
                request.query = $0.query
            }
            let _ = currentCondition.map {
                let currentCondition = CurrentCondition(context: self.container.viewContext)
                currentCondition.feelsLikeC = $0.feelsLikeC
                currentCondition.tempC = $0.tempC
                let _ = $0.langRu.map{
                    currentCondition.weatherStatus = $0.value
                }
            }
            let _ = weather.map{
                let weather = Weather(context: self.container.viewContext)
                weather.date = $0.date
                weather.mintempC = $0.mintempC
                weather.maxtempC = $0.maxtempC
            }
                    
                do {
                    try self.container.viewContext.save()
                    self.getData()
                } catch {}
            DispatchQueue.main.async {
                self.dayWeather2TableView.reloadData()
                self.dayWeather2CollectionView.reloadData()
            }
        }
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
        dayCell2.descriptionLabel2.text = cellcurrentCondition.weatherStatus
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

