//
//  BaseTableViewController.swift
//  NewProject
//
//  Created by hưng hoàng on 4/20/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mTableView: UITableView!
    var dataArray : [String]?
    var titleStirt = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = ["A","B" ,"C"]
//        self.setupDataAndReload(data:data)
        self.mTableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        self.mLabel.text = titleStirt

    }
    //MARK: Action
    @IBAction func backScreen(_ sender: Any) {
//        backButtonPress()
    }
    //MARK: Base
//    func setupDataAndReload(data:[String]){
//        dataArray = data
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (dataArray != nil){
          return dataArray!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dataArray![indexPath.item])
    }

}
