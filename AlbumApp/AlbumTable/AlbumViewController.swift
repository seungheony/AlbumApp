//
//  ViewController.swift
//  AlbumApp
//
//  Created by 김승헌 on 2023/02/04.
//

import UIKit
import Photos

class AlbumViewController: UIViewController {

    let smartList = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
    let imageManager = PHCachingImageManager()
    var fetchResults: [PHFetchResult<PHAsset>] = []
    var fetchOptions: PHFetchOptions {
         let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
     }
    
    // 앨범 리스트를 표시할 UITableView
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 85
        PHPhotoLibrary.shared().register(self)
        addAlbums(collection: smartList)
        navigationController?.navigationBar.prefersLargeTitles = true

    }

    private func addAlbums(collection : PHFetchResult<PHAssetCollection>){
        for i in 0 ..< collection.count {
            let collection = collection.object(at: i)
            self.fetchResults.append(PHAsset.fetchAssets(in: collection, options: fetchOptions))
        }
    }
}

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else {
            return AlbumTableViewCell()
        }
        
        let collection = smartList.object(at: indexPath.row)
        cell.albumTitle.text = collection.localizedTitle
        
        cell.numberImagesAlbum.text = String(fetchResults[indexPath.row].count)
        
        
        guard let asset = fetchResults[indexPath.row].firstObject else {
            return cell
        }
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 70, height: 70), contentMode: .aspectFit, options: nil) { (image, _) in
            cell.albumThumbnail?.image = image
        }
        return cell
    }
}

extension AlbumViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        for i in 0..<self.fetchResults.count {
            if let changes = changeInstance.changeDetails(for: fetchResults[i]) {
                fetchResults[i] = changes.fetchResultAfterChanges
            }
        }

        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
}
