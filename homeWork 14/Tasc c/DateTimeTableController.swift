//
//  DateTimeTableController.swift
//  homeWork 14
//
//  Created by Андрей Таланчук on 06.02.2021.
//

import UIKit

class DateTimeTableController: UITableViewController {
    
    var newDate = ""
    var newTime = ""
    var completition: ((String) -> Void)?
    let localId = Locale.preferredLanguages.first!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerAction(self)
        
        self.datePicker.locale = Locale(identifier: self.localId)
        self.datePicker.minimumDate = Date()
        self.timePicker.locale = Locale.init(identifier: self.localId)
        self.timePicker.minimumDate = Date()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        datePickerAction(self)
        self.datePicker.locale = Locale(identifier: self.localId)
        self.datePicker.date = Date()
        self.datePicker.minimumDate = Date()
        
        self.timePicker.locale = Locale.init(identifier: self.localId)
        self.timePicker.date = Date()
        self.timePicker.minimumDate = Date()
        self.timePicker.contentMode = .right
    }

    @IBOutlet var dateTimeTableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func datePickerAction(_ sender: Any) {
        
        DispatchQueue.main.async {
            if  self.datePicker.calendar.isDateInToday(self.datePicker.date) == true{
                self.timePicker.minimumDate = Date()
                self.dateTimeTableView.reloadData()
            } else {
                self.timePicker.minimumDate = .none
                self.dateTimeTableView.reloadData()}
        }
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EE, dd-MMM"
        formatter.locale = Locale(identifier: self.localId)
        let newDate = formatter.string(from: datePicker.date)
        self.newDate = newDate
        completition?(newDate)
    }
    
    @IBAction func timePickerAction(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: self.localId)
        let newTime = formatter.string(from: timePicker.date)
        self.newTime = newTime
        adTime()
    }
    
    func adTime(){
        let fullDate = "\(self.newDate), \(self.newTime)"
        completition?(fullDate)
        
    }

    
    
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
