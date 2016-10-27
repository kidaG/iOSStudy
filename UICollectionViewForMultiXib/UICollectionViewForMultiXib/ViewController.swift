//
//  ViewController.swift
//  UICollectionViewForMultiXib
//
//  Created by yuya on 2016/10/25.
//  Copyright © 2016年 yuya. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    let num = ["10", "20", "30", "40", "50", "-1",
               "10", "20", "30", "40", "50", "-1",
               "10", "20", "30", "40", "50", "-1",
               "10", "20", "30", "40", "50", "-1",
               "10", "20", "30", "40", "50", "-1",
               "10", "20", "30", "40", "50", "-1",
               "10", "20", "30", "40", "50", "-1",
               "10", "20", "30", "40", "50", "-1",
               "10", "20", "30", "40", "50", "-1",
               "10", "20", "30", "40", "50", "-1"]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setCustomCellXib()
    }
    
    // UICollectionViewのセルIDとXibファイルを関連付ける。このため、Storyboard上では、どのセルがどのカスタムセルであるかといった情報を設定する必要はない。xibのviewにカスタムセルを関連付ける。
    private func setCustomCellXib(){
        
        let nib: UINib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        let nib2: UINib = UINib(nibName: "CustomCollectionViewCell2", bundle: nil)
        collectionView.register(nib2, forCellWithReuseIdentifier: "Cell2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return num.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let row = indexPath.row
        
        let identifier:String = {
            if (row%2 == 0){
                return "Cell"
            }else{
                return "Cell2"
            }
        }()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? CustomCollectionViewCell{
        
            let n = self.num[row]
            print(n)
            print("n.description:" + n.description)
            cell.setLabelString(text: n.description)
            return cell
        }else if let cell = cell as? CustomCollectionViewCell2{
            print("Cell is not defined")
            
            let n = self.num[row]
            print(n)
            print("n.description:" + n.description)
            //cell.setLabelString(text: n.description)
            
            return cell
        }else{
            fatalError()
        }
        
        
    }

}

