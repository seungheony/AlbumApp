//
//  AssetCollectionViewCell.swift
//  AlbumApp
//
//  Created by 김승헌 on 2023/02/06.
//

import UIKit

class AssetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImage.image = nil
    }
}
