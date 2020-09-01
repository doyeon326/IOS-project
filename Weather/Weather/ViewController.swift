//
//  ViewController.swift
//  Weather
//
//  Created by Tony Jung on 2020/08/23.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    var countries: [Countries] = []
    @IBOutlet weak var countryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //json
        self.navigationItem.title = "세계날씨"
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else { return }
        do {
            self.countries = try jsonDecoder.decode([Countries].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        self.countryTableView.reloadData()
        
        countryTableView.delegate = self
        countryTableView.dataSource = self
        
        //making table view look good
        countryTableView.separatorStyle = .none
        countryTableView.showsVerticalScrollIndicator = false
    }

    

}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        let country = countries[indexPath.row]
        cell.countryLabel.text = country.korean_name
        cell.countryImg?.image = UIImage(named: "flag_" + country.asset_name)
        return cell
    }
    
    // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        if segue.identifier == "sgCity"{
            guard let cityViewController: CityViewController = segue.destination as? CityViewController else{  return }
            guard let cell: UITableViewCell = sender as? UITableViewCell else{ return }
            
            let indexPath = self.countryTableView.indexPath(for: cell )
            cityViewController.textToSet = countries[((indexPath as! NSIndexPath).row)].asset_name
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.countryTableView.reloadData()
        //뷰가 노출 될때마다 리로드
    }
    
   
}

