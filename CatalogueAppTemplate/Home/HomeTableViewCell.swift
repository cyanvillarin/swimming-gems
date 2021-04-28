//
//  HomeTableViewCell.swift
//  CatalogueAppTemplate
//
//  Created by CYAN on 2021/04/28.
//

import UIKit
import AlamofireImage

class HomeTableViewCell: UITableViewCell {
   
   @IBOutlet var titleLabel: UILabel!
   @IBOutlet var subtitleLabel: UILabel!
   @IBOutlet var itemImageView: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      itemImageView.layer.cornerRadius = 5.0
      itemImageView.layer.masksToBounds = true
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
   func initWithData(data: ItemObject) {
      titleLabel.text = data.title
      subtitleLabel.text = data.subtitle
   }
   
}
