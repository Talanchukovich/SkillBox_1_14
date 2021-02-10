//
//  WeatherViewController2.swift
//  homeWork12
//
//  Created by Андрей Таланчук on 20.01.2021.
//

import UIKit

class WeatherViewController2: UIViewController {

    @IBOutlet weak var dayWeather2CollectionView: UICollectionView!
 
    @IBOutlet weak var dayWeather2TableView: UITableView!
    
    let persistance = Persistance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayWeather2CollectionView.delegate = self
        self.dayWeather2CollectionView.dataSource = self
        self.dayWeather2TableView.dataSource = self
        self.persistance.loadWeather()
        
        DispatchQueue.main.async {
            self.dayWeather2CollectionView.reloadData()
            self.dayWeather2TableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let loader = WeatherLoader2()
        loader.dayWeather2 {[weak self] requestData, currentConditionData, weatherData  in
            guard let self = self else {return}
            self.persistance.saveWeather(request: requestData, currentCondition: currentConditionData, weather: weatherData)
            DispatchQueue.main.async {
                self.dayWeather2CollectionView.reloadData()
                self.dayWeather2TableView.reloadData()
            }
        }

    }
}

extension WeatherViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persistance.savedRequest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dayCell2 = dayWeather2CollectionView.dequeueReusableCell(withReuseIdentifier: "DayCell2", for: indexPath) as! DayCell2
        let cellRequest = persistance.savedRequest[indexPath.item]
        let cellcurrentCondition = persistance.savedCurrentCondition[indexPath.item]
        let cellweather = persistance.savedWeather[indexPath.item]
        dayCell2.nameLabel2.text = cellRequest.query
        dayCell2.tempLabel2.text = cellcurrentCondition.tempC
        dayCell2.descriptionLabel2.text = cellcurrentCondition.langRu[indexPath.row].value
        dayCell2.feelsLikeLabel2.text = "Ощущается как \(cellcurrentCondition.feelsLikeC)º"
        dayCell2.minMaxTempLabel2.text = "Макс. \(cellweather.maxtempC)º мин. \(cellweather.mintempC)º"
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
        return persistance.savedWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let daysCell2 = dayWeather2TableView.dequeueReusableCell(withIdentifier: "DaysCell2", for: indexPath) as! DaysCell2
        let weatherCell = persistance.savedWeather[indexPath.row]
        daysCell2.temp_minLabel2.text = weatherCell.mintempC + "º"
        daysCell2.temp_maxLabel2.text = weatherCell.maxtempC + "º"
        daysCell2.dateLabel2.text = dateFormatter(date: weatherCell.date).replacingOccurrences(of: ", ", with: ", \n").firstUppercased.replacingOccurrences(of: "2021", with: "").replacingOccurrences(of: "г.", with: "")
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

