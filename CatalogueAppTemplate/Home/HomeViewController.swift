//
//  ViewController.swift
//  CatalogueAppTemplate
//
//  Created by CYAN on 2021/04/28.
//

import UIKit
import Firebase
import GoogleMobileAds
import Nuke
import AppTrackingTransparency
import AdSupport

class HomeViewController: UIViewController {
   
   var interstitial: GADInterstitial!
   
   var itemList: [ItemObject] = []
   
   @IBOutlet var tableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      if #available(iOS 14, *) {
         ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
            // Tracking authorization completed. Start loading ads here.
         })
      }
      
      self.title = "Swimming Gems"
      navigationController?.navigationBar.barTintColor = navigationBarThemeColor
      navigationController?.navigationBar.tintColor = UIColor.white
      navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
      navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: navigationBarThemeColor]
      
      // config googleAds
      var adUnitId = ""
      if isForRelease {
         adUnitId = prodUnitId
      } else {  // testing
         adUnitId = testUnitId
      }
      
      // instantiate the ad unit
      interstitial = GADInterstitial(adUnitID: adUnitId)
      
      // requests the ad
      requestAd()
      
      tableView.delegate = self
      tableView.dataSource = self
      tableView.separatorStyle = .none
      
      tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
      
      if let stringTSV = readDataFromTSV(fileName: "data", fileType: "tsv") {
         let array = convertDataIntoArray(data: stringTSV)
         itemList = convertArrayIntoClassList(data: array)
      }
      
   }
   
   override func viewWillAppear(_ animated: Bool) {
      navigationController?.navigationBar.prefersLargeTitles = true
   }
   
   // request ad if not yet requested
   func requestAd() {
      let isAdRequested = UserDefaults.standard.bool(forKey: "isAdRequested")
      if !isAdRequested {
         NSLog("Requesting ads.")
         let request = GADRequest()
         interstitial.load(request)
         UserDefaults.standard.set(true, forKey: "isAdRequested")
      } else {
         NSLog("Ad was already requested.")
      }
   }
   
   // show ads if its ready, and it hasn't been shown yet
   func showAd() {
      let isAdShown = UserDefaults.standard.bool(forKey: "isAdShown")
      if !isAdShown {
         // checks if the interstitial is instantiated properly
         if interstitial != nil {
            if interstitial.isReady {
               NSLog("Presenting ads.")
               interstitial.present(fromRootViewController: self)
               UserDefaults.standard.set(true, forKey: "isAdShown")
            } else {
               NSLog("Ad is not ready yet.")
            }
         }
      } else {
         NSLog("Ad was shown already.")
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

extension HomeViewController: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 93.0
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return itemList.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
      cell.initWithData(data: itemList[indexPath.row])
      cell.selectionStyle = .none
      
      if let imageURL = URL(string: itemList[indexPath.row].image_link) {
         let options = ImageLoadingOptions(
            placeholder: UIImage(named: "default-item-image"),
            transition: .fadeIn(duration: 0.33),
            failureImage: UIImage(named: "default-item-image"),
            failureImageTransition: .fadeIn(duration: 0.33)
         )
         Nuke.loadImage(with: imageURL, options: options, into: cell.itemImageView)
      }
      
      return cell
   }
   
   override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
   }
   
}

extension HomeViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController,
         let navigator = navigationController {
         viewController.itemData = itemList[indexPath.row]
         showAd()
         navigator.pushViewController(viewController, animated: true)
      }
   }
}
