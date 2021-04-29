//
//  DetailViewController.swift
//  CatalogueAppTemplate
//
//  Created by CYAN on 2021/04/28.
//

import Foundation
import UIKit
import Nuke

class DetailViewController: UIViewController {
   
   @IBOutlet var itemImageView: UIImageView!
   @IBOutlet var subtitleLabel: UILabel!
   @IBOutlet var descriptionLabel: CustomTextView!
   @IBOutlet var referenceLabel: UILabel!
   
   var itemData: ItemObject!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.title = itemData.title
      self.navigationItem.largeTitleDisplayMode = .never
      
      let backButton = UIBarButtonItem()
      backButton.title = "Back"
      navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
      
      itemImageView.layer.cornerRadius = 8.0
      itemImageView.layer.masksToBounds = true
      
      if let imageURL = URL(string: itemData.image_link) {
         let options = ImageLoadingOptions(
            placeholder: UIImage(named: "default-item-image"),
            transition: .fadeIn(duration: 0.33),
            failureImage: UIImage(named: "default-item-image"),
            failureImageTransition: .fadeIn(duration: 0.33)
         )
         Nuke.loadImage(with: imageURL, options: options, into: itemImageView)
      }
      
      subtitleLabel.text = itemData.subtitle
      descriptionLabel.text = itemData.description
      descriptionLabel.isUserInteractionEnabled = false
      referenceLabel.text = itemData.reference
   }
   
   override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
   }
   
}
