//
//  ViewController.swift
//  MyWeather
//
//  Created by Tony Jung on 2020/08/25.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{

    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "country"
    var country: [Country] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let countries: Country = self.country[indexPath.row]
        
        cell.textLabel?.text = countries.korean_name
       // cell.detailTextLabel?.text = countries.asset_name
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
            return
        }
        
        do{
            self.country = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        }catch{
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }


}

