//
//  ViewController.swift
//  Todo
//
//  Created by Tony Jung on 2021/02/04.
//
import Amplify
import AmplifyPlugins
import UIKit
import Combine

class ViewController: UIViewController {
    var todoSubscription: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeTodos()
        // Do any additional setup after loading the view.
     
    }

    private func addTodo(_ title: String, _ priority: Priority,_ description: String){
          let item = Todo(id: UUID().uuidString, name: title, priority: priority, description: description)
          Amplify.DataStore.save(item) { result in
              switch result {
              case .success(let savedItem):
                  print("Saved Item: \(savedItem.name)")
              case .failure(let error):
                  print("Could not save item to dataStore: \(error)")
              }
          }
      }
    
    private func queryTodo() {
        Amplify.DataStore.query(Todo.self, completion: { result in
            switch(result) {
            case .success(let todos):
                for todo in todos {
                    print("==== Todo ====")
                    print("Name: \(todo.name)")
                    if let priority = todo.priority {
                        print("Priority: \(priority)")
                    }
                    if let description = todo.description {
                        print("Description: \(description)")
                    }
                }
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        })
    }
    
    private func updateTodo(_ title: String) {
        Amplify.DataStore.query(Todo.self,
            where: Todo.keys.name.eq(title),
            completion: {
                result in
                switch (result) {
                    case.success(let todos):
                        guard todos.count == 1,
                            var updatedTodo = todos.first
                        else {
                            print("Did not find exactly one todo, bailing")
                            return
                        }
                        updatedTodo.name = "File quarterly taxes"
                        Amplify.DataStore.save(updatedTodo,
                            completion: {
                                result in
                                switch (result) {
                                    case.success(let savedTodo):
                                        print("Updated item: \(savedTodo.name )")
                                    case.failure(let error):
                                        print("Could not update data in Datastore: \(error)")
                                }
                            })
                    case.failure(let error):
                        print("Could not query DataStore: \(error)")
                }
            })
    }
    
    private func deleteTodo(_ title: String) {
        Amplify.DataStore.query(Todo.self,
            where: Todo.keys.name.eq("title"),
            completion: {
                result in
                switch (result) {
                    case.success(let todos):
                        guard todos.count == 1,
                            let toDeleteTodo = todos.first
                        else {
                            print("Did not find exactly one todo, bailing")
                            return
                        }
                        Amplify.DataStore.delete(toDeleteTodo,
                            completion: {
                                result in
                                switch (result) {
                                    case.success:
                                        print("Deleted item: \(toDeleteTodo.name)")
                                    case.failure(let error):
                                        print("Could not update data in Datastore: \(error)")
                                }
                            })
                    case.failure(let error):
                        print("Could not query DataStore: \(error)")
                }
            })
    }

    func subscribeTodos() {
       self.todoSubscription
           = Amplify.DataStore.publisher(for: Todo.self)
               .sink(receiveCompletion: { completion in
                   print("Subscription has been completed: \(completion)")
               }, receiveValue: { mutationEvent in
                   print("Subscription got this value: \(mutationEvent)")
               })
    }
}

