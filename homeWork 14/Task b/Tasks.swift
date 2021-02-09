//
//  Tasks.swift
//  homeWork 14
//
//  Created by Андрей Таланчук on 30.01.2021.
//

import Foundation
import RealmSwift


class ToDo: Object {

    @objc dynamic var toDo = ""

}


class Tasks {
    
    var allTasks: Results <ToDo>!
    
    private let realm = try! Realm()
    
    var newTask: String = ""
    var editTask = ""
    var deletIndex = 0
    var editIndex = 0
    
    func adTasks(){
        let task = ToDo()
        task.toDo = self.newTask
        
        try! realm.write {
            realm.add(task)
        }
        self.allTasks = realm.objects(ToDo.self)
    }
    
    func deletTasks(){
        let task = self.allTasks[deletIndex]
        try! realm.write{
            realm.delete(task)
        }
        self.allTasks = realm.objects(ToDo.self)
    }
    
    func editTasks(){
        let task = self.allTasks[editIndex]
        try! realm.write{
            task.toDo = self.editTask
        }
        self.allTasks = realm.objects(ToDo.self)
    }
    
    
    func reloadTasks(){
        self.allTasks = realm.objects(ToDo.self)
    }
}



