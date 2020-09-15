//
//  ListCollectionViewController.swift
//  Album
//
//  Created by Tony Jung on 2020/09/02.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit
import Photos


class ListCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout  {
    var results: PHAssetCollection? 
    var fetchResult : PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    var ascendingStat: Bool = false
    var imageIndex: Int = 0
    var count = 0
    var images: [UIImage] = []
    
    @IBOutlet var barButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var selectButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(false, animated: true)
        self.navigationItem.title = results?.localizedTitle //setting up navigation header
       // navigationController?.navigationBar.prefersLargeTitles = false
        
        shareButton.isEnabled = false
        shareButton.tintColor = UIColor.clear
        trashButton.isEnabled = false
        trashButton.tintColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadView()
        count = 0
        navigationItem.title = results?.localizedTitle
    }
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: ascendingStat)]
            self.fetchResult = PHAsset.fetchAssets(in: results!, options: fetchOptions)
        
       // fetchResult = PHAsset.fetchAssets(in: results!, options: nil)
            return fetchResult.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        
        let asset: PHAsset = fetchResult.object(at: indexPath.item)
        imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil, resultHandler: {image, _ in
            cell.photoImg.image = image
            
        })
        
        if !collectionView.allowsMultipleSelection{
            cell.layer.borderWidth = 0
            images.removeAll()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemSpacing: CGFloat = 2
            let margin: CGFloat = 2
            let width = (collectionView.bounds.width - itemSpacing - margin * 3) / 3
            let height = width
            return CGSize(width: width, height: height)
    }


 
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you selected cell \(indexPath.item)")
        count += 1
        print(count)
        self.navigationItem.title = "\(count)장 선택"
        let selectedCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
            selectedCell.layer.borderWidth = 2
               
        if !collectionView.allowsMultipleSelection{
            //한장 선택했을때,
             imageIndex = indexPath.item
             performSegue(withIdentifier: "PresentImage", sender: self)
        }
       
        //선택된 이미지 저장
        let asset: PHAsset = fetchResult.object(at: indexPath.item)
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 115, height: 115), contentMode: .aspectFill, options: nil, resultHandler: {image, _ in
            self.images.append(image!)
        })
        
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
         count -= 1
         self.navigationItem.title = "\(count)장 선택"
         let unselectedCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
              unselectedCell.layer.borderWidth = 0
        //선택이 헤지가 된 셀 또한 지워줘야함
        
    }
    
    @IBAction func selectItem(_ sender: UIButton){
        
        if collectionView.allowsMultipleSelection{
            count = 0
            self.navigationItem.title = results?.localizedTitle //setting up navigation header
           
            selectButton.title = "선택"
            collectionView.allowsMultipleSelection = false
      
            shareButton.isEnabled = false
            shareButton.tintColor = UIColor.clear
            trashButton.isEnabled = false
            trashButton.tintColor = UIColor.clear
            barButton.isEnabled = true
            barButton.tintColor = UIColor.blue
            collectionView.reloadData()
        
            
        }
        else{
            collectionView.allowsMultipleSelection = true
            selectButton.title = "취소"
            shareButton.isEnabled = true
            shareButton.tintColor = UIColor.blue
            trashButton.isEnabled = true
            trashButton.tintColor = UIColor.blue
            barButton.isEnabled = false
            barButton.tintColor = UIColor.lightGray
      
            
        }
        print("selectMultipleitem true")
    }
    
    @IBAction func ascendingOrder(_ sender: UIButton){
        if barButton.title == "최신순" {
            ascendingStat = true
            barButton.title = "과거순"
        }
        else{
            ascendingStat = false
            barButton.title = "최신순"
           
        }
         collectionView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
//        guard let nextViewController: ImageViewController = segue.destination as? ImageViewController else { return }
//        guard let cell: ListCollectionViewCell = sender as? ListCollectionViewCell else { return }
//        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
//
//        nextViewController.asset = self.fetchResult.object(at: indexPath.item)
//        nextViewController.str = "hello"
        if (segue.identifier == "PresentImage") {
            if let vc: ImageViewController = segue.destination as? ImageViewController {
//            guard let cell: ListCollectionViewCell = sender as? ListCollectionViewCell else { return }
         //   guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
//                 vc.asset = self.fetchResult[indexPath.item]
//               // vc.asset = self.fetchResult.object(at: indexPath.item)
               // vc.imageView.image = fetchResult[]
                vc.asset = fetchResult[imageIndex]
                vc.str = "hello"
                }

            }
        

    }
    

    @IBAction func shareAction(_ sender: Any) {
      //  let textToShare: String = "안녕하세요, 부스트 코스입니다."
       // let urlToShare: String = "http://www.edwith.org/boostcourse-ios"
        
        let activityViewController = UIActivityViewController(activityItems: images, applicationActivities: nil)
        // 2. 기본으로 제공되는 서비스 중 사용하지 않을 UIActivityType 제거(선택 사항)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact]
        // 3. 컨트롤러를 닫은 후 실행할 완료 핸들러 지정
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
            // 성공했을 때 작업
           }  else  {
            // 실패했을 때 작업
           }
        }

        self.present(activityViewController, animated: true, completion: nil)
    }
}


