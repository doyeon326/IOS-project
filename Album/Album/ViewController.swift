//
//  ViewController.swift
//  Album
//
//  Created by Tony Jung on 2020/08/31.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    var results:[PHAssetCollection] = [] //앨범을 담을 곳
   
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationStatus()
        navigationController?.navigationBar.prefersLargeTitles = true
        UIApplication.shared.statusBarStyle = .lightContent

        collectionView.reloadData()
        
        //viewdidload에 넣어줘야함 하지만 뒤로갈땐?
     //   navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
     
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        //self.loadView()
       //navigationController?.setNavigationBarHidden(true, animated: animated)
      navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    func requestAlbums(){
        /*.smartAlbum : Favorites, Panoramas, Recents, Slo-mo, Screenshots, Bursts, Videos, Hidden, Time-lapse, Animated, Long Exposure, Portrait, Live Photos
         
          .albums : user created album
         
            >subtype: .any / .albumRegular
         */
        
        let systemAlbumResult: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
        let userAlbumResult: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)

        //만약 해당 앨범의 사진의 갯수가 0 보다 크다면 results에대가 앨범을 append
        systemAlbumResult.enumerateObjects({(collection, index, object) in
            let photoInAlbum = PHAsset.fetchAssets(in: collection, options: nil)
            if photoInAlbum.count > 0 {
                self.results.append(systemAlbumResult.object(at: index))
            }
        })
        //위와 동일
        userAlbumResult.enumerateObjects({(collection, index, object) in
            let photoInAlbum = PHAsset.fetchAssets(in: collection, options: nil)
            if photoInAlbum.count > 0 {
                self.results.append(userAlbumResult.object(at: index))
            }
        })
       //print(userAlbumResult.object(at: 0).localizedTitle)
    }

    
    func authorizationStatus(){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가됨")
            self.collectionView.reloadData()
            //self.requestCollection()
            self.requestAlbums()
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status{
                case .authorized:
                    print("사용자가 허용함")
                    OperationQueue.main.addOperation {
                        self.collectionView.reloadData()
                    }
                   // self.requestCollection()
                    self.requestAlbums()
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        default: break
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    //howmany
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results.count
    }
    
    //how
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let asset: PHAssetCollection = self.results[indexPath.item]
        
        //fetchOptionsettings 최신순이 아님 ㅎ
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: asset, options: fetchOptions)
        cell.albumCount.text = String(fetchResult.count)
        cell.albumTitle.text = asset.localizedTitle
        
        imageManager.requestImage(for: fetchResult.lastObject!,
                                  targetSize: CGSize(width: 180, height: 240),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { image, _ in
                                    cell.albumImage.image = image
        })
        return cell
    }
   
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    //size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 15
        let margin: CGFloat = 15
        let width = (collectionView.bounds.width - itemSpacing * 3 - margin * 2) / 2
        let height = width + 60
        return CGSize(width: width, height: height)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: ListCollectionViewController = segue.destination as? ListCollectionViewController else { return }
        guard let cell: AlbumCollectionViewCell = sender as? AlbumCollectionViewCell else { return }
        let indexPath = self.collectionView.indexPath(for: cell)
        nextViewController.results = self.results[(indexPath?.item)!]
        
       // print(self.results[(indexPath?.item) as! Int].localizedTitle)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //해더 스크롤 안보이게
        //해더 스크롤시 보이게
     
    }
    
    /*
     수정해야하는 부분 :
     
     ViewController : 헤더부분 제어, 스크롤시 헤더보임
     ListCollectionView: 선택된 아이탬 공유, 삭제, 취소 눌렀을시 선택된아이템 해지
        // prepare 값 안넘어감... 
     ImageViewController: header 센터 조정, 공유 사진?(icloud 확인), 좋아요일경우 해지, 사진 Zoom 했을 때 이미지 고정
     
     
     */
    

 
}

