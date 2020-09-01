//
//  CityViewController.swift
//  Weather
//
//  Created by Tony Jung on 2020/08/24.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit
/*
 state
 10: sunny
 11  cloudy
 12: rainy
 13: snowy
 
 */
class CityViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var cityTableView: UITableView!
    
    var textToSet: String?
    let cellIdentifier: String = "cityCell"
    var cities: [Cities] = []
    var state: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.rowHeight = 150
        self.navigationItem.title = textToSet
        self.cityTableView.delegate = self
        self.cityTableView.dataSource = self
        decodejson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // self.textLabel.text = self.textToSet
    }
    
    
    
}

extension CityViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CityTableViewCell
        let city = cities[indexPath.row]
        cell.cityName.text = city.city_name
        cell.celsius.text = "섭씨"+String(city.celsius)
        cell.fahrenheit.text = "화씨"+convertToFahrenheit(c: city.celsius)
        cell.rainfall.text = "강수확률"+String(city.rainfall_probability)+"%"
        
        
        switch city.state {
        case 10:
            cell.cityImg.image = UIImage(named: "sunny" )
            state = 10
        case 11:
            cell.cityImg.image = UIImage(named: "cloudy" )
            state = 11
        case 12:
            cell.cityImg.image = UIImage(named: "rainy" )
            state = 12
        case 13:
            cell.cityImg.image = UIImage(named: "snowy" )
            state = 13
        default:
            cell.cityImg.image = UIImage(named: "sunny" )
            state = 10
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail"{
            guard let detailViewController: DetailViewController = segue.destination as? DetailViewController else{  return }
            guard let cell: CityTableViewCell = sender as? CityTableViewCell else{ return }
        
            detailViewController.celsius = cell.celsius.text ?? "0"
            detailViewController.rain = cell.rainfall.text ?? "0"
            detailViewController.fahrenheit = cell.fahrenheit.text ?? "0"
            detailViewController.state = state ?? 0
            detailViewController.city = cell.cityName.text ?? "0"
        }
    }
    
    
    func convertToFahrenheit(c: Double)->String{
        let f: Double = c * 9 / 5 + 32
        return String((f*10).rounded()/10)
    }
    
    func decodejson(){
        let jsonDecoder: JSONDecoder = JSONDecoder()
               guard let dataAsset: NSDataAsset = NSDataAsset(name: textToSet! ) else { return }
               do{
                   self.cities = try jsonDecoder.decode([Cities].self, from: dataAsset.data)
               } catch {
                   print(error.localizedDescription)
               }
               self.cityTableView.reloadData()
    }

}

