//
//  PhotoGallaryCollectionViewController.swift
//  CoreDataFeature
//
//  Created by yuya on 2015/11/24.
//  Copyright © 2015年 yuya. All rights reserved.
//

import UIKit
import Photos
private let reuseIdentifier = "PhotoCellId"
private let albumName = "My App"

class PhotoGallaryCollectionViewController: UICollectionViewController {
    var albumFound:Bool = false
    var assetCollection: PHAssetCollection?
    var photoAsset: PHFetchResult?
    
    override func viewDidLoad() {
        print("viewDidLoad PhotoGallaryCollectionViewController");
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        if(collection.firstObject != nil){
            self.albumFound = true
            self.assetCollection = collection.firstObject as? PHAssetCollection
        }else{
            //create Folder
            print("Folder")
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(albumName)
                }, completionHandler: {
                    (success:Bool, error:NSError?) in
                    print("success:" + String(success))
                    self.albumFound = success
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
        if(self.assetCollection != nil){
            self.photoAsset = PHAsset.fetchAssetsInAssetCollection(self.assetCollection!, options: nil)
        }
        self.collectionView?.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.photoAsset?.count
        if(count == nil){
            return 0
        }
        
        return count!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? PhotoThumnailCell
        if(cell == nil || self.photoAsset == nil){
            return PhotoThumnailCell()
        }
        let asset = self.photoAsset![indexPath.item] as? PHAsset
        PHImageManager.defaultManager().requestImageForAsset(asset!, targetSize: PHImageManagerMaximumSize, contentMode: .AspectFill, options: nil, resultHandler: {
            (result, info) in
                cell!.setThumnail(result!)
        })
        // Configure the cell
        return cell!
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "GallaryToPhoto"){
            let controller = segue.destinationViewController as? PhotoViewController
            let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell)
            controller?.index = indexPath?.item
            controller?.photoAsset = self.photoAsset
            controller?.assetCollection = self.assetCollection
            
        }
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
