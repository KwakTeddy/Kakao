//
//  ViewController.swift
//  iTunesApi_KakaoBank
//
//  Created by Teddy Kwak on 2017. 6. 2..
//  Copyright © 2017년 Teddy Kwak. All rights reserved.
//

import UIKit
import Kingfisher

class iTunesAppListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var iTunesAppArray = [iTunesAppModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        let model = iTunesAppViewModel()
        model.getData { [weak self] (dataArray) in
            DispatchQueue.main.async {
                self!.iTunesAppArray = dataArray
                self!.tableView.reloadData()
            }
        }
    }
}

extension iTunesAppListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iTunesAppArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! iTunesAppListViewCell
        cell.model = iTunesAppArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let iTunesAppModel = iTunesAppViewModel()
        iTunesAppModel.iTuncesAppDetailWithPublicModel(iTunesModel: iTunesAppArray[indexPath.row], superController: self)
    }
    
}











