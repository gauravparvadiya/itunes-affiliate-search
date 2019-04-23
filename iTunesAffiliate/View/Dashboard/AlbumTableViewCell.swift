//
//  AlbumTableViewswift
//  iTunesAffiliate
//
//  Created by Krupa Detroja on 19/04/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artiestNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var index: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(album: Album) {
        index.text = "\(self.tag + 1)."
        albumNameLabel.text = "Album Name: \(album.collectionName ?? "")"
        artiestNameLabel.text = "Artist Name: \(album.artistName ?? "")"
        releaseDateLabel.text = "Release Date: \(convertDateInFormat(text: album.releaseDate ?? ""))"
        albumImageView.sd_imageIndicator?.startAnimatingIndicator()
        albumImageView.sd_setImage(with: URL(string: "\(album.artworkUrl100 ?? "")")) { (image, error, cacheType, url) in
            if error != nil {
                debugPrint(error as Any, "my error")
            }
        }
    }
}
