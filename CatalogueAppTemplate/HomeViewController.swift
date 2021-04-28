//
//  ViewController.swift
//  CatalogueAppTemplate
//
//  Created by CYAN on 2021/04/28.
//

import UIKit

class HomeViewController: UIViewController {
   
   var itemList: [ItemObject] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      if let stringTSV = readDataFromTSV(fileName: "data", fileType: "tsv") {
         let array = convertDataIntoArray(data: stringTSV)
         itemList = convertArrayIntoClassList(data: array)
      }
      
   }
   
   func readDataFromTSV(fileName:String, fileType: String) -> String? {
      
      guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType) else {
         return nil
      }
      
      do {
         let contents = try String(contentsOfFile: filepath, encoding: .utf8)
         return contents
      } catch {
         print("File Read Error for file \(filepath)")
         return nil
      }
   }
   
   func convertDataIntoArray(data: String) -> [[String]] {
       var result: [[String]] = []
       let rows = data.components(separatedBy: "\n")
       for row in rows {
           let columns = row.components(separatedBy: "\t")
           result.append(columns)
       }
       return result
   }
   
   func convertArrayIntoClassList(data: [[String]]) -> [ItemObject] {
      var tempItemList: [ItemObject] = []
      for i in 1...(data.count-1) {
         let itemObject = ItemObject(itemData: data[i])
         tempItemList.append(itemObject)
      }
      return tempItemList
   }
   
   
}

