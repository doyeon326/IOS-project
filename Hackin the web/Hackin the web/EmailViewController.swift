//
//  EmailViewController.swift
//  Hackin the web
//
//  Created by Tony Jung on 2020/11/09.
//

import UIKit

class EmailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension EmailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = ""
        return cell
    }
}
