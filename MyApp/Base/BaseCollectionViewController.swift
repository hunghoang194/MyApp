//
//  BaseCollectionViewController.swift
//  NewProject
//
//  Created by hưng hoàng on 4/20/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class BaseCollectionViewController: BaseViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var labelBaseContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.mCollectionView.register(UINib(nibName: "FirtCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "firtCell")
        let data = ["A","B" ,"C"]
        self.setupDataAndReload(data:data)
        labelBaseContent.text = "Firt VC"
    }
    func setupDataAndReload(data:[String]){
        dataArray = data
    }
    @IBAction func backScreen(_ sender: Any) {
        backButtonPress()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FirtCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "firtCell", for: indexPath) as! FirtCollectionViewCell
        cell.setupCell(title:self.dataArray![indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // câu lệnh này là khởi tạo 1 view controller có id là BaseTableViewController
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "BaseTableViewController") as! BaseTableViewController
        // câu lệnh này là gọi cái label labelContent trong viewtroller secondVC rồi gán text của nó bằng self.dataArray![indexPath.item]
        secondVC.titleStirt = self.dataArray![indexPath.item] // lý do nó đang báo lỗi là do secondVC k có label tên là labelContent ?? Giờ thì nó đúng r
        // Lúc nãy nó bị crash tại sao ? VÌ nó gọi đến thằng không toionf tại
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

}
