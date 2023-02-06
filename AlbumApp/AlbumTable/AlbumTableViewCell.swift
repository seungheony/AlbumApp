//
//  TableViewCell.swift
//  AlbumApp
//
//  Created by 김승헌 on 2023/02/05.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    // 앨범 썸네일 이미지
    @IBOutlet weak var albumThumbnail: UIImageView!
    // 앨범 제목
    @IBOutlet weak var albumTitle: UILabel!
    // 앨범에 포함된 이미지 개수
    @IBOutlet weak var numberImagesAlbum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
