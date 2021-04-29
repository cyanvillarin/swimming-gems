//
//  ItemObject.swift
//  CatalogueAppTemplate
//
//  Created by CYAN on 2021/04/28.
//

import Foundation

class ItemObject {
   var title: String!
   var cacheKey: String!
   var subtitle: String!
   var description: String!
   var image_link: String!
   var reference: String!
   
   init(itemData: [String]) {
      title = itemData[0]
      cacheKey = title.lowercased().replacingOccurrences(of: " ", with: "_")  /// Ex: Change Kohaku Koi into kohaku_koi as cache key
      subtitle = itemData[1]
      description = itemData[2]
      image_link = itemData[3]
      reference = itemData[4]
   }
}
