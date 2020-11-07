//
//  ViewController.swift
//  Firestore
//
//  Created by Tony Jung on 2020/11/04.
//

import UIKit
//firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore //why?

class ViewController: UIViewController {
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        //[START setup]
        // Do any additional setup after loading the view.
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
       // addDataToFireStore()
        //addSecondDataToFireStore()
      //  readDataFromFireStore()
       // addThirdData()
       // setDocumentWithCodable()
       // dataTypes()
       // setData()
       // addDocument() //cities
      //  newDocument()
      //  updateDocument()
       // deleteField()
        deleteDocument()
        
   
        
    }
    func addDataToFireStore(){
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }

    func addSecondDataToFireStore(){
        // Add a second document with a generated ID.
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Alan",
            "middle": "Mathison",
            "last": "Turing",
            "born": 1912
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func readDataFromFireStore(){
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func addThirdData(){
        db.collection("cities").document("LA").setData([
                   "name": "Los Angeles",
                   "state": "CA",
                   "country": "USA"
               ]) { err in
                   if let err = err {
                       print("Error writing document: \(err)")
                   } else {
                       print("Document successfully written!")
                   }
               }
    }
    
    private func setDocumentWithCodable() {
         // [START set_document_codable]
         let city = City(name: "Los Angeles",
                         state: "CA",
                         country: "USA",
                         isCapital: false,
                         population: 5000000)

         do {
             try db.collection("cities").document("LA").setData(from: city)
         } catch let error {
             print("Error writing city to Firestore: \(error)")
         }
         // [END set_document_codable]
     }
    
    private func dataTypes() {
           // [START data_types]
           let docData: [String: Any] = [
               "stringExample": "Hello world!",
               "booleanExample": true,
               "numberExample": 3.14159265,
               "dateExample": Timestamp(date: Date()),
               "arrayExample": [5, true, "hello"],
               "nullExample": NSNull(),
               "objectExample": [
                   "a": 5,
                   "b": [
                       "nested": "foo"
                   ]
               ]
           ]
           db.collection("data").document("one").setData(docData) { err in
               if let err = err {
                   print("Error writing document: \(err)")
               } else {
                   print("Document successfully written!")
               }
           }
           // [END data_types]
       }
    
    private func setData() {
         let data: [String: Any] = [:]

         // [START set_data]
         db.collection("cities").document("new-city-id").setData(data)
         // [END set_data]
     }
    
    private func addDocument() {
           // [START add_document]
           // Add a new document with a generated id.
           var ref: DocumentReference? = nil
           ref = db.collection("cities").addDocument(data: [
               "name": "Tokyo",
               "country": "Japan"
           ]) { err in
               if let err = err {
                   print("Error adding document: \(err)")
               } else {
                   print("Document added with ID: \(ref!.documentID)")
               }
           }
           // [END add_document]
       }
    
    private func newDocument() {
            // [START new_document]
            let newCityRef = db.collection("cities").document()

            // later...
            newCityRef.setData([
                // [START_EXCLUDE]
                "name": "Some City Name"
                // [END_EXCLUDE]
            ])
            // [END new_document]
        }
    
    private func updateDocument() {
         // [START update_document]
         let washingtonRef = db.collection("cities").document("DC")

         // Set the "capital" field of the city 'DC'
         washingtonRef.updateData([
             "capital": true
         ]) { err in
             if let err = err {
                 print("Error updating document: \(err)")
             } else {
                 print("Document successfully updated")
             }
         }
         // [END update_document]
     }
    private func deleteDocument() {
           // [START delete_document]
           db.collection("cities").document("DC").delete() { err in
               if let err = err {
                   print("Error removing document: \(err)")
               } else {
                   print("Document successfully removed!")
               }
           }
           // [END delete_document]
       }
    private func deleteField() {
         // [START delete_field]
         db.collection("cities").document("DC").updateData([
             "capital": FieldValue.delete(),
         ]) { err in
             if let err = err {
                 print("Error updating document: \(err)")
             } else {
                 print("Document successfully updated")
             }
         }
         // [END delete_field]
     }


}

// [START codable_struct]
public struct City: Codable {

    let name: String
    let state: String?
    let country: String?
    let isCapital: Bool?
    let population: Int64?

    enum CodingKeys: String, CodingKey {
        case name
        case state
        case country
        case isCapital = "capital"
        case population
    }

}
