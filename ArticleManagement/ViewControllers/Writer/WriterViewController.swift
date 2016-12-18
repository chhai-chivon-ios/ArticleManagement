//
//  WriterViewController.swift
//  ArticleManagement
//
//  Created by sophatvathana on 9/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import UIKit

class WriterViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
   
    @IBOutlet var btnAction: UIButton!
    @IBOutlet var titleArticle: UITextField!
    var articleViewData:ArticleViewData?
    @IBOutlet var featureImage: UIImageView!
    @IBOutlet var content: UITextView!
    var imagePicker:UIImagePickerController?
    let userPresenter = UserPresenter(userService: UserService())
    var userData:UserViewData?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEditData()
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        //imagePicker?.allowsEditing = true;
        self.title = "Writer"
        self.view.backgroundColor = UIColor.viewBackgroundColor
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("tapDetected"))
        singleTap.numberOfTapsRequired = 1
        self.featureImage.isUserInteractionEnabled = true
        self.featureImage.addGestureRecognizer(singleTap)
        userPresenter.attachView(view: self)
        userPresenter.getUser()
        // Do any additional setup after loading the view.
    }
   
//    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController?.selectedIndex = 1
//    }
    
    
    //Action
    func tapDetected() {
        imagePicker?.allowsEditing = false
        imagePicker?.sourceType = .photoLibrary
        present(imagePicker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Work hery")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("asda")
                featureImage.image = image
        self.dismiss(animated: true, completion: nil)
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        dismiss(animated: true, completion: nil)
    }
    
    func loadEditData() {
        if self.articleViewData == nil{
            self.btnAction.setTitle("Create New", for: .application)
        }else{
            self.btnAction.setTitle("Update", for: .application)
        }
        self.titleArticle.text = articleViewData?.title
        self.content.text = articleViewData?.description
        if let featureImage = articleViewData?.image  {
            SonadevImageCacher.sharedInstance.getImage(url: URL(string:featureImage)!, completion: {
                image, error in
                if error != nil{
                    
                }else if image != nil {
                    self.featureImage.image = image
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitData(_ sender: Any) {
        if articleViewData != nil{
            if let featureImage = featureImage.image {
            HttpManager.uploadSingleImage(featureImage, success: {
                model in
                print(model)
                let json:[String : Any] = [
                    "TITLE": self.titleArticle.text ?? "",
                    "DESCRIPTION": self.content.text,
                    "AUTHOR": self.userData?.id ?? 1201,
                    "CATEGORY_ID": 1,
                    "STATUS": 1,
                    "IMAGE": model.data!
                ]
                let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let session = URLSession(configuration: .default)
                session.synTask(url: URL(string:"\(Config.API_URL)articles/\(self.articleViewData!.id!)")!, "PUT", withData: jsonData, completionHandler: {data,response,error in
                    if error == nil {
        
                        self.navigationController?.popViewController(animated: true)
                        
                    }else {
                        print("asdasd")
                        
                    }
                })
            }, failure: {
                print("Will error")
            })
            }
        
        }else{
            print("Create")
            if let image = featureImage.image {
            HttpManager.uploadSingleImage(image, success: {
                model in
                print(model)
                let json:[String : Any] = [
                    "TITLE": self.titleArticle.text ?? "",
                    "DESCRIPTION": self.content.text,
                    "AUTHOR": self.userData?.id ?? 1201,
                    "CATEGORY_ID": 1,
                    "STATUS": 1,
                    "IMAGE": model.data!
                ]
                let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let session = URLSession(configuration: .default)
                session.synTask(url: URL(string:"\(Config.API_URL)articles")!, "POST", withData: jsonData, completionHandler: {data,response,error in
                    if error == nil {
                        let d = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        self.tabBarController?.selectedIndex = 0;
                        print(d!)
                    }else {
                        print("asdasd")
                        
                    }
                })
            }, failure: {
                print("Will error")
            })

            }
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
extension WriterViewController:UserView {
    
    func startLoading() {
    
    }
    
    func finishLoading() {
    
    }
    
    func setUser(user: UserViewData) {
         userData = user
    }
    
    func setEmptyUser() {
        
    }
    
    
}

