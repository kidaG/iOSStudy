//
//  PhotoViewController.swift
//  CoreDataFeature
//
//  Created by yuya on 2015/11/24.
//  Copyright © 2015年 yuya. All rights reserved.
//

import UIKit
import Photos
class PhotoViewController: UIViewController {
    var assetCollection: PHAssetCollection?
    var photoAsset: PHFetchResult?
    var index: Int?
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBAction func btnCancel(sender: AnyObject) {
        print("Cancel")
//        self.navigationController?.popToRootViewControllerAnimated(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad PhotoViewController");

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true
        self.displayPhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayPhoto(){
        let imgManager = PHImageManager.defaultManager()
        var Id = imgManager.requestImageForAsset(self.photoAsset![self.index!] as! PHAsset, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFill, options: nil, resultHandler: {
            (result, info) in
            self.imgView?.image = result
        })
    }

}
