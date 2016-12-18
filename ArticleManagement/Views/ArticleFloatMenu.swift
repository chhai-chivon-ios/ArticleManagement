//
//  ArticleFloatMenu.swift
//  ArticleManagement
//
//  Created by sophatvathana on 10/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
//import RxSwift

private let kActionViewWidth: CGFloat = 140   //container view width
private let kActionViewHeight: CGFloat = 190    //container view height
private let kActionButtonHeight: CGFloat = 44   //button height
private let kFirstButtonY: CGFloat = 12 //the first button Y value

class ArticleFloatMenu: UIView {
    weak var delegate: ActionFloatViewDelegate?
   // let disposeBag = DisposeBag()
    
    override init (frame: CGRect) {
        super.init(frame : frame)
        self.initContent()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
        self.initContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func initContent() {
        self.backgroundColor = UIColor.clear
        let actionImages = [
            ArticleMNImageDI.newsfeed_normal.image,
            ArticleMNImageDI.newsfeed_normal.image,
            ArticleMNImageDI.newsfeed_normal.image,
            ]
        
        let actionTitles = [
            "By DateTime",
            "By Title",
            "By Author",
            ]
        
        //Init containerView
        let containerView : UIView = UIView()
        containerView.backgroundColor = UIColor.clear
        self.addSubview(containerView)
        containerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(3)
            make.right.equalTo(self.snp.right).offset(-5)
            make.width.equalTo(kActionViewWidth)
            make.height.equalTo(kActionViewHeight)
        }
        
        //Init bgImageView
        let stretchInsets = UIEdgeInsetsMake(14, 6, 6, 34)
        let bubbleMaskImage = ArticleMNImageDI.articleRightTopBg.image.resizableImage(withCapInsets: stretchInsets, resizingMode: .stretch)
        let bgImageView: UIImageView = UIImageView(image: bubbleMaskImage)
        containerView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(containerView)
        }
        
        //init custom buttons
        var yValue = kFirstButtonY
        for index in 0 ..< actionImages.count {
            let itemButton: UIButton = UIButton(type: .custom)
            itemButton.backgroundColor = UIColor.clear
            itemButton.titleLabel!.font = UIFont.systemFont(ofSize: 17)
            itemButton.setTitleColor(UIColor.white, for: UIControlState())
            itemButton.setTitleColor(UIColor.white, for: .highlighted)
            itemButton.setTitle(actionTitles[index], for: .normal)
            itemButton.setTitle(actionTitles[index], for: .highlighted)
            itemButton.setImage(actionImages[index], for: .normal)
            itemButton.setImage(actionImages[index], for: .highlighted)
            itemButton.addTarget(self, action: #selector(ArticleFloatMenu.buttonTaped(_:)), for: UIControlEvents.touchUpInside)
            itemButton.contentHorizontalAlignment = .left
            itemButton.contentEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0)
            itemButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            itemButton.tag = index
            containerView.addSubview(itemButton)
            
            itemButton.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(containerView.snp.top).offset(yValue)
                make.right.equalTo(containerView.snp.right)
                make.width.equalTo(containerView.snp.width)
                make.height.equalTo(kActionButtonHeight)
            }
            yValue += kActionButtonHeight
        }
        
        //add tap to view
        let tap = UITapGestureRecognizer()
        self.addGestureRecognizer(tap)
//        tap.rx.event.subscribe { _ in
//            self.hide(true)
//            }.addDisposableTo(self.disposeBag)
        
        self.isHidden = true
    }
    
    func buttonTaped(_ sender: UIButton!) {
        guard let delegate = self.delegate else {
            self.hide(true)
            return
        }
        
        let type = ActionFloatViewItemType(rawValue:sender.tag)!
        delegate.floatViewTapItemIndex(type)
        self.hide(true)
    }
    
    /**
     Hide the float view
     
     - parameter hide: is hide
     */
    func hide(_ hide: Bool) {
        if hide {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.2 ,
                           animations: {
                            self.alpha = 0.0
            },
                           completion: { finish in
                            self.isHidden = true
                            self.alpha = 1.0
            })
        } else {
            self.alpha = 1.0
            self.isHidden = false
        }
    }
    
    /*
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
}



/**
 *  ActionFloatViewDelegate Float view delegate methods
 */
protocol ActionFloatViewDelegate: class {
    /**
     Tap the item with index
     */
    func floatViewTapItemIndex(_ type: ActionFloatViewItemType)
}

enum ActionFloatViewItemType: Int {
    case dateTime = 0, title, author
}


