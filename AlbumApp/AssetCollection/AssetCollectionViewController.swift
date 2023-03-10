//
//  AssetCollectionViewController.swift
//  AlbumApp
//
//  Created by 김승헌 on 2023/02/06.
//

import UIKit
import Photos

private let reuseIdentifier = "Cell"

class AssetCollectionViewController: UICollectionViewController {
    
    // 각 행과 열의 간격 설정
    let interval: CGFloat = 4
    
    var fetchResults: PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PHPhotoLibrary.shared().register(self)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let assetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! AssetCollectionViewCell
        let asset = fetchResults.object(at: indexPath.item)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            assetCell.thumbnailImage.image = image
        })
        assetCell.thumbnailImage.contentMode = .scaleAspectFill
        return assetCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let asset = fetchResults.object(at: indexPath.item)
        let resource = PHAssetResource.assetResources(for: asset).first
        let fileName = resource?.originalFilename ?? "File Name Error"
        let fileSize: String = String(format: "%.1f", (resource?.value(forKey: "fileSize") as? Double ?? 0) / 1048576)
        
        let alert = UIAlertController(title: "사진정보", message: "\(fileName)\n\(fileSize)MB", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { (action) in
            
        })
        present(alert, animated: true, completion: nil)
    }
}

extension AssetCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    //전체 width에서 두칸의 interval을 빼준 뒤 3을 나눠주어 셀 하나의 width를 구한다.
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {

            let width: CGFloat = ( UIScreen.main.bounds.width - interval * 2 ) / 3
            return CGSize(width: width , height: width )
    }

    // 각 가로 행간을 interval로 설정한다.
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return interval
    }

    // 각 세로 자간을 interval로 설정한다.
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return interval
    }
}

extension AssetCollectionViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        if let changes = changeInstance.changeDetails(for: fetchResults) {
            fetchResults = changes.fetchResultAfterChanges
        }

        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }
}
