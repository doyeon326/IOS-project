//
//  TableViewController.swift
//  MyMovieChart
//
//  Created by Tony Jung on 2020/11/21.
//

import UIKit

class TableViewController: UITableViewController {

  //  var list = [MovieVO]()
    var dataset = [("다크나이트","영웅물에 철학에 음악까지 더해져 예술이 된다.","2008-09-04",8.95),
    ("다크나이트","영웅물에 철학에 음악까지 더해져 예술이 된다.","2008-09-04",8.95),
    ("다크나이트","영웅물에 철학에 음악까지 더해져 예술이 된다.","2008-09-04",8.95)]
    
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        for(title, des, opendate, rating) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = des
            mvo.opendate = opendate
            mvo.rating = rating
            
            datalist.append(mvo)
        }
        return datalist
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = row.title
        return cell
    }
}
