//
//  NewsDetailViewController.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    @IBOutlet var featureImage: UIImageView!
    @IBOutlet var content: UILabel!
    @IBOutlet var articleTitle: UILabel!
    var article:ArticleViewData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let featureImgUrl = article?.image{
            SonadevImageCacher.sharedInstance.getImage(url: URL(string:featureImgUrl)!, completion: {
                image, error in
                if error != nil{
                    
                }else if image != nil {
                    self.featureImage.image = image
                }

            })
        }
        articleTitle.text = article?.title
        content.text = article?.description
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
