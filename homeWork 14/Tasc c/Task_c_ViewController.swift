//
//  Task_c_ViewController.swift
//  homeWork 14
//
//  Created by Андрей Таланчук on 02.02.2021.
//

import UIKit
//import SnapKit

class Task_c_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTasks()
        cancellButton.isEnabled = false
        adView.layer.cornerRadius = 10
        adView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.cornerRadius = 4
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = #colorLiteral(red: 0.7998480435, green: 0.7998480435, blue: 0.7998480435, alpha: 1)
        self.taskTableView2.delegate = self
        self.taskTableView2.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
   
    var keyboardHeight: CGFloat = 0
    var keyboardDuration: Double = 0
    var keyboardCurve: UInt = 0
    var newDate = ""
    var adTaskButtonEdingMode = false
    var editIndex = 0
    
   
   
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var taskTableView2: UITableView!
    @IBOutlet weak var taskTextField2: UITextField!
    @IBOutlet weak var adTaskButtonOutlet: UIButton!
    @IBOutlet weak var cancellButton: UIBarButtonItem!
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.keyboardHeight = keyboardHeight
        }
        if let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            self.keyboardDuration = keyboardDuration
        }
        if let keyboardCurve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            self.keyboardCurve = keyboardCurve
        }
    }
    
    func animateView(type: Bool) {
        
        func animation(_ animation: @escaping ()-> Void) {
        UIView.animate(withDuration: self.keyboardDuration, delay: 0, options: UIView.AnimationOptions(rawValue: self.keyboardCurve), animations: animation, completion: nil)
        }
        DispatchQueue.main.async {
            switch type {
            case false:
                animation({
                    self.view.layoutIfNeeded()
                    self.taskTableView2.backgroundColor = .none
                })
                self.taskTableView2.reloadData()
            case true:
                animation({
                    self.view.layoutIfNeeded()
                    self.taskTableView2.backgroundColor = .lightGray
                })
                self.taskTableView2.reloadData()
            }
        }
        
    }
    
    func closeAdView() {
        
        DispatchQueue.main.async {
            self.taskTableView2.reloadData()
        }
        taskTableView2.allowsSelection = true
        self.adTaskButtonEdingMode = false
        self.constraint.constant = 0
        self.view.endEditing(true)
        tvc?.removeFromParent()
        tvc?.datePickerAction(self)
        
    }
    
    @IBAction func adButton(_ sender: Any) {
        taskTableView2.allowsSelection = false
        taskTextField2.becomeFirstResponder()
        cancellButton.isEnabled = true
        self.constraint.constant = -(self.keyboardHeight - self.view.layoutMargins.bottom + 270)
        animateView(type: true)
        
        if self.adTaskButtonEdingMode == false {
            self.adTaskButtonOutlet.setTitle("Добавить задачу", for: .normal)
        }
        else {
            self.adTaskButtonOutlet.setTitle("Редактировать задачу", for: .normal)
            self.taskTextField2.text = self.models[self.editIndex].taskName
        }
    }
    
    @IBAction func adTaskButton(_ sender: Any) {
        if self.adTaskButtonEdingMode == false {
            adTask()
        }  else if self.adTaskButtonEdingMode == true {
            editTask(index: editIndex)
        }
        closeAdView()
        animateView(type: false)
        cancellButton.isEnabled = false
    }
        
    
    @IBAction func cancelAction(_ sender: Any) {
        closeAdView()
        animateView(type: false)
        cancellButton.isEnabled = false
    }
    
    
    // DateTimeTableController
    weak var tvc: DateTimeTableController?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPicker" {
            if let tvc = segue.destination as? DateTimeTableController {
                self.tvc = tvc
                tvc.completition = {[weak self] date in
                    guard let self = self else {return}
                    self.newDate = date
                }
            }
        }
        
    }
    
    
    // Core Data
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [TaskToDoC]()
    
    func getAllTasks() {
        do {
            models = try context.fetch(TaskToDoC.fetchRequest()).sorted(by: {(initial, next) -> Bool in
                
                return initial.taskDate ?? "" < next.taskDate ?? ""
                })
            DispatchQueue.main.async {
                self.taskTableView2.reloadData()
            }
        }
        catch {}
    }
    
    func adTask() {
        if self.taskTextField2.text != "" {
            let newTask = TaskToDoC(context: context)
            newTask.taskName = self.taskTextField2.text
            newTask.taskDate = self.newDate
            let formatter = DateFormatter()
            formatter.dateFormat = "EE, dd-MMM, HH:mm"
            formatter.dateFormat = "EE, dd-MMM"
            formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
            newTask.sortDate = formatter.date(from: self.newDate)
            print(newTask.sortDate as Any)
        }
        do {
            try context.save()
            getAllTasks()
        } catch {}
    }
    
    func deletTask(deleteTask: TaskToDoC) {
        context.delete(deleteTask)
        do {
            try context.save()
            getAllTasks()
        } catch {}
    }
    
    func editTask(index: Int){
        if self.taskTextField2.text != "" {
            let newTask = self.taskTextField2.text
            models[index].taskName = newTask
            models[index].taskDate = self.newDate
            
            do {
                try context.save()
                getAllTasks()
            } catch {}
        }
    }
    
}


// TableView


extension Task_c_ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView2.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskTableViewCell
        let model = self.models[indexPath.row]
        cell.taskLabel.text = model.taskName
        guard let text = model.taskDate else {return cell}
        cell.dateLabel.text = "Выполнить в " + text
        cell.backgroundColor = self.taskTableView2.backgroundColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletSwipe = UIContextualAction(style: .normal, title: "Удалить", handler: {
            _,_,_  in
            let deleteTask = self.models[indexPath.row]
            self.deletTask(deleteTask: deleteTask)
        })
        
        let editSwipe = UIContextualAction(style: .normal, title: "Изменить", handler: {
            action,_,_ in
            self.adTaskButtonEdingMode = true
            self.adButton(self)
            self.editIndex = indexPath.row
        })
        
        deletSwipe.backgroundColor = .red
        editSwipe.backgroundColor = .lightGray
        return UISwipeActionsConfiguration(actions: [editSwipe, deletSwipe])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskTableView2.deselectRow(at: indexPath, animated: true)
        self.editIndex = indexPath.row
        let sheet = UIAlertController(title: "Редактировать задачу", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Редактировать", style: .default, handler: {
            [weak self] _ in
            guard let self = self else {return}
            self.adTaskButtonEdingMode = true
            self.adButton(self as Any)
            
        }))
        sheet.addAction(UIAlertAction(title: "Удалить задачу", style: .destructive, handler: {
            [weak self] _ in
            guard let self = self else {return}
            let deleteTask = self.models[indexPath.row]
            self.deletTask(deleteTask: deleteTask)
        }))
        
        sheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        present(sheet, animated: true)
    }
}

