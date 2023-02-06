//
//  TableViewCell.swift
//  AlbumApp
//
//  Created by 김승헌 on 2023/02/05.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumThumbnail: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
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
