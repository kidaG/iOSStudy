//
//  ViewController.swift
//  UICollectionViewForMultiXib
//
//  Created by yuya on 2016/10/25.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit

extension Array {
    subscript (safe index: Int) -> Element? {
        get {
            print("なぜよばれないし１1")
            return self.indices ~= index ? self[index] : nil
        }
        set (value) {
            print("なぜよばれないし２1")
            if value == nil {
                return
            }
            if !(self.indices ~= index) {
                NSLog("WARN: index:\(index) is out of range, so ignored. (array:\(self))")
                return
            }
            
            self[index] = value!
        }
    }
}

let test = [1,2,3,4]

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    let num:Array<String> = ["10", "20", "30", "40"]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return num.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CustomCollectionViewCell{
        
            print("CustomCollectionViewCell:" + indexPath.description)
            print("indexPath.row:" + indexPath.row.description)
            
            let n = self.num[indexPath.row]
            print(n)
            print("n.description:" + n.description)
            cell.setLabelString(text: n.description)
            return cell
        }else{
            print("Cell is not defined")
            
            let cell = UICollectionViewCell()
            return cell
        }
        
        
    }

}

