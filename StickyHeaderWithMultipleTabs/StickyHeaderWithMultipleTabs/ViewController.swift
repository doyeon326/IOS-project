//
//  ViewController.swift
//  StickyHeaderWithMultipleTabs
//
//  Created by doyeona on 2021/09/14.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    let maxHeight: CGFloat = 400.0 //headerView의 최대 높이값
    let minHeight: CGFloat = 75.0 //headerVIew의 최소 높이값

    @IBOutlet weak var mainTableView: UITableView!{
        didSet {
            mainTableView.contentInset = UIEdgeInsets(top: maxHeight, left: 0, bottom: 0, right: 0)
         }
    }
    
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint! {
        didSet {
            heightConstraint.constant = maxHeight
        }
    }
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    private let tableViewIdentifier = "ListOfTableViewCell"
    private let collectionViewIdentifier = "TabMenuCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
//MARK: - TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath) as? ListOfTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .brown
        
        return cell
    }
    
    
    //MARK: - TABLEVIEW SECTION
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        view.backgroundColor = .white
        let label: UILabel = {
            let label = UILabel()
            label.frame = CGRect(x: 10, y: 0, width: 100, height: 50)
            label.text = "\(section + 1) Day"
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 22, weight: .semibold)
            label.textColor = .black
            
            return label
        }()
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

//MARK: - StickyHeader with multiple Tab Menus
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewIdentifier, for: indexPath) as? TabMenuCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 60)
    }
    
    
}

//
extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            heightConstraint.constant = max(abs(scrollView.contentOffset.y), minHeight)
        } else {
          //  heightConstraint.constant = minHeight
        }
      //  let offset = -scrollView.contentOffset.y
      //  let percentage = (offset-100)/50
     //   menuCollectionView.alpha = percentage
        
    }
}
