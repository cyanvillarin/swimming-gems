//
//  DetailViewController.swift
//  CatalogueAppTemplate
//
//  Created by CYAN on 2021/04/28.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
   
   @IBOutlet var itemImageView: UIImageView!
   @IBOutlet var subtitleLabel: UILabel!
   @IBOutlet var descriptionLabel: CustomTextView!
   @IBOutlet var referenceLabel: UILabel!
   
   var itemData: ItemObject!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.title = itemData.title
      
      if let imageURL = URL(string: itemData.image_link) {
         itemImageView.af.setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.5))
      }
      
      subtitleLabel.text = itemData.subtitle
      descriptionLabel.text = itemData.description
      referenceLabel.text = itemData.reference1
   }
   
}
