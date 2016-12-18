//
//  ArticleManagementUIVC.swift
//  ArticleManagement
//
//  Created by sophatvathana on 9/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//


import Foundation
import UIKit

extension UIViewController {

    class func initFromNib() -> UIViewController {
        let hasNib: Bool = Bundle.main.path(forResource: self.nameOfClass, ofType: "nib") != nil
        guard hasNib else {
            assert(!hasNib, "ប៉ារ៉ាម៉ែតទ័រមិនត្រឹមត្រូវ") // here
            return UIViewController()
        }
        return self.init(nibName: self.nameOfClass, bundle: nil)
    }
    
    public static var topViewController: UIViewController? {
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
            print("មានកំហុស៖ អ្នកមិនមានផ្ទាំងទេសភាពណាមួយទេ។⁣ អ្នកចាំបាច់ត្រូវហៅវានៅក្នុង viewDidLoad ឬក៍ព្យាយាមដាក់នៅក្នុង⁣ viewDidAppear។")
        }
        return presentedVC
    }
    
    fileprivate func pushViewController(_ viewController: UIViewController, animated: Bool, hideTabbar: Bool) {
        viewController.hidesBottomBarWhenPushed = hideTabbar
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    fileprivate func popViewController(_ viewController: UIViewController, animated: Bool, hideTabbar: Bool) {
        viewController.hidesBottomBarWhenPushed = hideTabbar
        self.navigationController?.popViewController(viewController, animated: animated, hideTabbar: hideTabbar)
    }
    
    public func pop(_ viewController: UIViewController) {
        self.popViewController(viewController, animated: true, hideTabbar: false)
    }
    
    /**
     push
     */
    public func push(_ viewController: UIViewController) {
        self.pushViewController(viewController, animated: true, hideTabbar: true)
    }
    
    public func pushWithoutHideTabbar(_ viewController: UIViewController, animated: Bool, hideTabbar: Bool){
        viewController.hidesBottomBarWhenPushed = hideTabbar
        self.navigationController?.pushViewController(viewController, animated: animated)

    }
    
    /**
     present
     */
    public func present(_ viewController: UIViewController, completion:(() -> Void)?) {
        let navigationController = UINavigationController(rootViewController: viewController)
        self.present(navigationController, animated: true, completion: completion)
    }
    
}




