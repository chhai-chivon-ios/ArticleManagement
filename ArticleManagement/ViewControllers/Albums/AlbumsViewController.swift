//
//  AlbumsViewController.swift
//  ArticleManagement
//
//  Created by sophatvathana on 15/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import UIKit
import YangMingShan

class AlbumsViewController: UIViewController, YMSPhotoPickerViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
        var images = [UIImage]()
        @IBOutlet weak var collectionView: UICollectionView!
    
        @IBAction func uploadFile(_ sender:AnyObject){
            print("Work")
            HttpManager.uploadImagesMultiParamOfImage(images , success: {
                model in
                print(model)
            }, failure: {
            
            })
        }
    
        @IBAction func presentPhotoPicker(_ sender: AnyObject) {
                let pickerViewController = YMSPhotoPickerViewController.init()
                
                pickerViewController.numberOfPhotoToSelect = 10
                
                let customColor = UIColor.init(red:248.0/255.0, green:217.0/255.0, blue:44.0/255.0, alpha:1.0)
                
                pickerViewController.theme.titleLabelTextColor = UIColor.black
                pickerViewController.theme.navigationBarBackgroundColor = customColor
                pickerViewController.theme.tintColor = UIColor.black
                pickerViewController.theme.orderTintColor = customColor
                pickerViewController.theme.orderLabelTextColor = UIColor.black
                pickerViewController.theme.cameraVeilColor = customColor
                pickerViewController.theme.cameraIconColor = UIColor.white
                pickerViewController.theme.statusBarStyle = .default
                
                self.yms_presentCustomAlbumPhotoView(pickerViewController, delegate: self)
        }
        
        func deletePhotoImage(_ sender: UIButton!) {
            //let mutableImages: NSMutableArray! = NSMutableArray.init(array: images)
            images.remove(at: sender.tag)
            
            self.collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: [IndexPath.init(item: sender.tag, section: 0)])
            }, completion: nil)
        }
        
        override func viewDidLoad() {
            let barButtonItem: UIBarButtonItem! = UIBarButtonItem.init(barButtonSystemItem: .organize, target: self, action:#selector(presentPhotoPicker(_:)))
            self.navigationItem.rightBarButtonItem = barButtonItem
            
            let barButtonItemLeft: UIBarButtonItem! = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action:#selector(uploadFile(_:)))
            self.navigationItem.leftBarButtonItem = barButtonItemLeft
            self.collectionView.registerCellNib(PhotoShowCollectionViewCell.self)
            
            
        }
        
        
        func photoPickerViewControllerDidReceivePhotoAlbumAccessDenied(_ picker: YMSPhotoPickerViewController!) {
            let alertController = UIAlertController.init(title: "Allow photo album access?", message: "Need your permission to access photo albumbs", preferredStyle: .alert)
            let dismissAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            let settingsAction = UIAlertAction.init(title: "Settings", style: .default) { (action) in
                UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
            }
            alertController.addAction(dismissAction)
            alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        func photoPickerViewControllerDidReceiveCameraAccessDenied(_ picker: YMSPhotoPickerViewController!) {
            let alertController = UIAlertController.init(title: "Allow camera album access?", message: "Need your permission to take a photo", preferredStyle: .alert)
            let dismissAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            let settingsAction = UIAlertAction.init(title: "Settings", style: .default) { (action) in
                UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
            }
            alertController.addAction(dismissAction)
            alertController.addAction(settingsAction)
        
            picker.present(alertController, animated: true, completion: nil)
        }
        
        func photoPickerViewController(_ picker: YMSPhotoPickerViewController!, didFinishPicking image: UIImage!) {
            picker.dismiss(animated: true) {
                self.images = [image]
                self.collectionView.reloadData()
            }
        }
        
        func photoPickerViewController(_ picker: YMSPhotoPickerViewController!, didFinishPickingImages photoAssets: [PHAsset]!) {
            
            picker.dismiss(animated: true) {
                let imageManager = PHImageManager.init()
                let options = PHImageRequestOptions.init()
                options.deliveryMode = .highQualityFormat
                options.resizeMode = .exact
                options.isSynchronous = true
                
                var mutableImages = [UIImage]()
                
                for asset: PHAsset in photoAssets
                {
                    let scale = UIScreen.main.scale
                    let targetSize = CGSize(width: (self.collectionView.bounds.width - 20*2) * scale, height: (self.collectionView.bounds.height - 20*2) * scale)
                    imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options, resultHandler: { (image, info) in
                        mutableImages.append(image!)
                    })
                }
                
                self.images = mutableImages
                self.collectionView.reloadData()
            }
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print(self.images.count)
            return self.images.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(PhotoShowCollectionViewCell.self, for: indexPath)
            cell?.photoview.image =  self.images[indexPath.item] as? UIImage
            
            return cell!
        }
    
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
        {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
        
}
