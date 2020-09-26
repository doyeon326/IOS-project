//
//  Todo.swift
//  Study01
//
//  Created by Tony Jung on 2020/09/26.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import Foundation

struct Todo: Codable, Equatable {
    let id: Int
    var isDone: Bool
    var detail: String
 
    
    mutating func update(isDone: Bool, detail: String) {
        self.isDone = isDone
        self.detail = detail
    }
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

//class TodoManager {
//    static let shared = TodoManager()
//    
//    static var lastId: Int = 0
//    var todos: [Todo] = []
//    
//    func createTodo(detail: String) -> Todo {
//        let nextId = TodoManager.lastId + 1
//        TodoManager.lastId = nextId
//        
//        return Todo(id: nextId, isDone: false, detail: detail)
//    }
//    
//    func addTodo(_ todo: Todo){
//        todos.append(todo)
//        saveTodo()
//    }
//    
//    func updateTodo(_ todo: Todo) {
//        guard let index = todos.firstIndex(of: todo) else { return }
//        todos[index].update(isDone: todo.isDone, detail: todo.detail)
//        saveTodo()
//    }
//    
//    func saveTodo() {
//        Storage.store(todos, to: .documents, as: "study.json")
//    }
//    func retrieveTodo() {
//        todos = Storage.retrive("study.json", from: .documents, as: [Todo].self) ?? []
//        let lastId = todos.last?.id ?? 0
//        TodoManager.lastId = lastId
//    }
//}
