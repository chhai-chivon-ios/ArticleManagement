//
//  TabBarViewController.swift
//  ArticleManagement
//
//  Created by sophatvathana on 9/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    let normalImagesArray = [
            ArticleMNImageDI.newsfeed_normal.image,
            ArticleMNImageDI.writer_normal.image,
            ArticleMNImageDI.writer_normal.image
        ]
    
    let selectedImagesArray = [
            ArticleMNImageDI.newsfeed_selected.image,
            ArticleMNImageDI.writer_normal.image,
            ArticleMNImageDI.writer_normal.image
        ]
    
    let viewControllerArray = [
            NewsfeedViewController.initFromNib(),
            WriterViewController.initFromNib(),
            AlbumsViewController.initFromNib()
        ]
    
    let titleArray = ["Home","Writter","Albums"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
        // Do any additional setup after loading the view.
    
    }
   
    func setupViewController(){
        
        let navigationVCArray = NSMutableArray()
        for (index, controller) in viewControllerArray.enumerated() {
            controller.tabBarItem!.title = self.titleArray[index]
            controller.tabBarItem!.image = normalImagesArray[index].withRenderingMode(.alwaysOriginal)
            controller.tabBarItem!.selectedImage = selectedImagesArray[index].withRenderingMode(.alwaysOriginal)
            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGray], for: UIControlState())
            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.tabbarSelectedTextColor], for: .selected)
            let navigationController = UINavigationController(rootViewController: controller)
            navigationVCArray.add(navigationController)
        }
        self.viewControllers = navigationVCArray.mutableCopy() as! [UINavigationController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(tabBarController: UITabBarController,
                          didSelectViewController viewController: UIViewController) {
        if let vc = viewController as? UINavigationController {
            vc.popViewController(animated: true);
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
