//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Tony Jung on 2020/12/14.
//

import UIKit
import CoreData

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    //Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Data for the table
    var items: [Person]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //Get items from Core Data
        fetchPeople()
        

    }
    
    
    func fetchPeople(){
        //Fetch the data from Core Data to display in the tableview
        do{
            self.items = try context.fetch(Person.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
        //Create alert
        let alert = UIAlertController(title: "Add person", message: "What is their names?", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //Get the textfield for the alert
            let textfield = alert.textFields![0]
            
            //TODO: Create a person object
            let newPerson = Person(context: self.context)
            newPerson.name = textfield.text
            newPerson.age = 20
            newPerson.gender = "Male"
            
            //TODO: Save the data
            do{
                try self.context.save()
            }
            catch{
                
            }
            
            //TODO: Re-fetch the data
            self.fetchPeople()
            
        }
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        
        //Get person from array and set the label
        let person = self.items![indexPath.row]
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            //Which person to remove
            let personToRemove = self.items![indexPath.row]
        
            //Remove the person
            self.context.delete(personToRemove)
            
            //Save the person
            do {
                try self.context.save()
            } catch {
                
            }
            self.fetchPeople()
             
        }
        
        //Return swipe actions
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Selected Person
        let person = self.items![indexPath.row]
        
        //Create alert
        let alert = UIAlertController(title: "Edit Person", message: "Edit name:", preferredStyle: .alert)
        alert.addTextField()
        
        //setting up the name
        let textfield = alert.textFields![0]
        textfield.text = person.name
        
        //Configure button handler
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
           //Get the textfield for the alert
            let textfield = alert.textFields![0]
            
            //Edit name property of person object
            person.name = textfield.text
            
            //save the data
            do{
                try self.context.save()
            }
            catch {
                
            }
        
            self.fetchPeople()
            
        }
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

