//
//  ImageViewController.swift
//  Album
//
//  Created by Tony Jung on 2020/09/04.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit
import Photos

class ImageViewController: UIViewController,UIScrollViewDelegate {
    var asset: PHAsset!
    var str: String!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var favoriteBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingUpImage()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(false, animated: true)
        settingUpTitle()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    func settingUpImage(){
        imageManager.requestImage(for: asset,
                                       targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
                                       contentMode: .aspectFill,
                                       options: nil,
                                       resultHandler: {image, _ in
                                        self.imageView.image = image
             })
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    
    @IBAction func favoriteAsset(_ sender: Any) {
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest(for: self.asset)
            request.isFavorite = !self.asset.isFavorite
        }, completionHandler: nil)
    
       
     //   let favorite: String = self.asset.isFavorite ? "heart.fill" : "heart"
         favoriteBar.image = UIImage(systemName: "heart.fill")
        
    }
    
    @IBAction func deleteAsset(_ sender: Any) {
        PHPhotoLibrary.shared().performChanges({ PHAssetChangeRequest.deleteAssets([self.asset as Any] as NSArray)}, completionHandler:nil)
        
        self.navigationController?.popViewController(animated: true)
        //수정사항.. :

    }
    //1. OperationQueue().addOperation을 어디에다가 써야 효율적일까?
    //2. 전 controller에서 index를따로 프로퍼티에다가 선언해서 다음 뷰컨트롤러에다가 넘겨줬는데 더 좋은 방법은?
    
    
    @IBAction func shareAsset(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        activityViewController.excludedActivityTypes = []
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
                   if success {
                   // 성공했을 때 작업
                  }  else  {
                   // 실패했을 때 작업
                  }
               }

               self.present(activityViewController, animated: true, completion: nil)
        
    }
    func settingUpTitle(){
        //navigationController?.navigationBar.prefersLargeTitles = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        guard let date: Date = asset.creationDate else {
            return
        }
        
        var timeAndDate:String  = dateFormatter.string(from: date) + "\n" + timeFormatter.string(from: date)
        
        
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0))
             label.backgroundColor = UIColor.clear
             label.numberOfLines = 0
             label.textAlignment = NSTextAlignment.center
             label.text = timeAndDate
             self.navigationItem.titleView = label
        
        //
    }
}
