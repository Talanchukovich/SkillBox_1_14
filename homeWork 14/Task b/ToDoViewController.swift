//
//  ToDoViewController.swift
//  homeWork 14
//
//  Created by Андрей Таланчук on 30.01.2021.
//

import UIKit

class ToDoViewController: UIViewController {
    
    var task = Tasks()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskTableView.delegate = self
        self.taskTableView.dataSource = self
        taskTextField.indent(size: 10)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        task.reloadTasks()
    }
    
    
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var adTaskView: UIView!
    @IBOutlet weak var editTaskView: UIView!
    @IBOutlet weak var adTaskViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var editTaskViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomEditTaskConstraint: NSLayoutConstraint!
    
    var taskButtonActionIndex = 0
    
    @IBAction func taskButtonAction(_ sender: Any) {
        taskButtonActionIndex += 1
        if taskButtonActionIndex > 2 {taskButtonActionIndex = 1}
        
        if taskButtonActionIndex == 1 {
            self.taskTextField.becomeFirstResponder()
        }
        
        if taskButtonActionIndex == 2 {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.adTaskViewConstraint.constant = -104
                self.adTaskView.layoutIfNeeded()
                self.taskTableView.backgroundColor = .none
                
            }, completion: nil)
            self.taskTextField.resignFirstResponder()
            self.taskTableView.reloadData()
            
           
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                if self.adTaskView.isHidden == false {
                    self.adTaskViewConstraint.constant = -168 - keyboardHeight
                    self.buttonBottomConstraint.priority = UILayoutPriority(rawValue: 997)
                    self.taskTextField.isHidden = false
                    self.taskTableView.backgroundColor = .lightGray
                    self.adTaskView.layoutIfNeeded()
                } else {
                    self.editTaskViewConstraint.constant = -168 - keyboardHeight
                    self.bottomEditTaskConstraint.priority = UILayoutPriority(rawValue: 997)
                    self.editTextField.isHidden = false
                    self.taskTableView.backgroundColor = .lightGray
                    self.editTaskView.layoutIfNeeded()
                }
            }, completion: nil)
        }
    }
    
    @IBAction func taskTextFieldAction(_ sender: Any) {
        let newTask = taskTextField.text
        if newTask != "" {
            task.newTask = newTask!
            task.adTasks()
        } else {return}
    }
    
    
    @IBAction func editButtonAction(_ sender: Any) {
        taskButtonActionIndex += 1
        if taskButtonActionIndex > 2 {taskButtonActionIndex = 1}
        
        if taskButtonActionIndex == 1 {
            self.adTaskView.isHidden = true
            self.editTaskView.isHidden = false
            self.editTaskView.backgroundColor = .white
            self.editTextField.becomeFirstResponder()
        }
        
        if taskButtonActionIndex == 2 {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.editTaskViewConstraint.constant = -104
                self.editTaskView.layoutIfNeeded()
                self.taskTableView.backgroundColor = .none
                
            }, completion: nil)
            self.adTaskView.isHidden = false
            self.editTaskView.isHidden = true
            self.editTextField.resignFirstResponder()
            self.taskTableView.reloadData()
        }
    }
    
    var editIndexPath = 0
    var oldText = ""
    @IBAction func editTextFieldAction(_ sender: Any) {
        let newTask = editTextField.text
        if newTask != "" {
            task.editTask = newTask!
            task.editIndex = self.editIndexPath
            task.editTasks()
            
        } else {return}
    }
    
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if task.allTasks != nil{
            let array = Array(task.allTasks)
            return array.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let item = Array(task.allTasks)[indexPath.row]
        cell.taskLabel.text = item.toDo
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeDelet = UIContextualAction(style: .normal, title: "Удалить") { (action, view, success) in
            self.task.deletIndex = indexPath.row
            self.task.deletTasks()
            self.taskTableView.reloadData()
        }
        let swipeEdit = UIContextualAction(style: .normal, title: "Изменить") { (action, view, success) in
            self.editButtonAction(action)
            let item = Array(self.task.allTasks)[indexPath.row]
            let oldText = item.toDo
            self.oldText = oldText
            
            let editIndexPath = indexPath.row
            self.editIndexPath = editIndexPath
        }
        swipeEdit.backgroundColor = #colorLiteral(red: 0.2282281584, green: 0.5864470898, blue: 1, alpha: 1)
        swipeDelet.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [swipeEdit, swipeDelet])

    }
    
    
}
extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
