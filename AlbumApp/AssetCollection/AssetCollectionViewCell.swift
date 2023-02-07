//
//  AssetCollectionViewCell.swift
//  AlbumApp
//
//  Created by 김승헌 on 2023/02/06.
//

import UIKit

class AssetCollectionViewCell: UICollectionViewCell {
    
    // 각 이미지의 썸네일
    @IBOutlet weak var thumbnailImage: UIImageView!
    var representedAssetIdentifier: String!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImage.image = nil
    }
}
