//
//  ViewModel.swift
//  iTunesApi_KakaoBank
//
//  Created by Teddy Kwak on 2017. 6. 5..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import Foundation
import SwiftyJSON
import SVProgressHUD


class iTunesAppViewModel: NSObject {
    
    func getData(complete:@escaping (_ array: [iTunesAppModel]) -> Void) {
        
        let iTunesApiURL = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"
        guard let urlRequest = URL(string: iTunesApiURL) else { return }
        
        SVProgressHUD.show()
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                SVProgressHUD.dismiss()
                return
            }

            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                var iTunesAppArray = [iTunesAppModel]()

                let parsingData = JSON(json)
                if let entryData = parsingData["feed"]["entry"].array {
                    
                    for entryDatas in entryData {
                        let itunesApp = iTunesAppModel()
                        
                        if let id = entryDatas["id"]["attributes"]["im:id"].string,
                            let name = entryDatas["im:name"]["label"].string,
                            let summary = entryDatas["summary"]["label"].string,
                            let releaseDate = entryDatas["im:releaseDate"]["attributes"]["label"].string,
                            let link = entryDatas["link"]["attributes"]["href"].string,
                            let artist = entryDatas["im:artist"]["label"].string,
                            let price = entryDatas["im:price"]["attributes"]["amount"].string,
                            let category = entryDatas["category"]["attributes"]["label"].string,
                            let imgUrl = entryDatas["im:image"][2]["label"].string {
                            
                            itunesApp.id = id
                            itunesApp.name = name
                            itunesApp.summary = summary
                            itunesApp.detailLink = link
                            itunesApp.releaseDate = releaseDate
                            itunesApp.category = category
                            itunesApp.artist = artist
                            itunesApp.price = price
                            itunesApp.imgUrl = imgUrl

                        }
                        iTunesAppArray.append(itunesApp)
                    }
                    complete(iTunesAppArray)
                    SVProgressHUD.dismiss()
                }
            } catch let error {
                print(error.localizedDescription)
                SVProgressHUD.dismiss()
            }
        }
        task.resume()
    }
    
    

    func iTuncesAppDetailWithPublicModel(iTunesModel: iTunesAppModel, superController: UIViewController) {
        
        let iTunesAppDetailVC = iTunesAppDetailViewController()
        iTunesAppDetailVC.id = iTunesModel.id
        superController.navigationController?.pushViewController(iTunesAppDetailVC, animated: true)
    }

}



































