//
//  ItemObject.swift
//  CatalogueAppTemplate
//
//  Created by CYAN on 2021/04/28.
//

import Foundation

class ItemObject {
   var title: String!
   var subtitle: String!
   var description: String!
   var image_link: String!
   var reference: String!
   
   init(itemData: [String]) {
      title = itemData[0]
      subtitle = itemData[1]
      description = itemData[2]
      image_link = itemData[3]
      reference = itemData[4]
   }
}
