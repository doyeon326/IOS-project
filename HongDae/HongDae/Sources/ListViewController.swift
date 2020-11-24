//
//  ListViewController.swift
//  HongDae
//
//  Created by Tony Jung on 2020/11/22.
//

import UIKit

typealias DataSource = (name:String, introduce:String)

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!

    let dataSources = [
        (name: "statistics", introduce: "hello"),
        (name: "status", introduce: "hello"),
        (name: "static", introduce: "hello"),
        (name: "stat", introduce: "hello"),
        (name: "stat", introduce: "hehellohellohellohellohellohellolloellohellohellohellohellohellollo")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HongDae"
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //셀을 몇개를 만들건지
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.nameLabel.text = dataSources[indexPath.row].name
        cell.introduceLabel.text = dataSources[indexPath.row].introduce
        return cell
    }
    
    
}
