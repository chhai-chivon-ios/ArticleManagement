//
//  NewsfeedViewController.swift
//  ArticleManagement
//
//  Created by sophatvathana on 9/12/16.
//  Copyright © 2016 sophatvathana. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class NewsfeedViewController: UIViewController {
    @IBOutlet weak var newsfeedListView:UITableView!
    @IBOutlet var newsfeedActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyView: UIView?
    let itemDataSource = ["asdsa","sadasd","sadasds","dfafad"]
    var searchbar:UISearchBar?
    var actionFloatView:ArticleFloatMenu!
    let articlePresenter = ArticlePresenter(articleService: ArticleService())
    var articleData = [ArticleViewData]()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    
    let PageSize = 15
    //var items = [ArticleViewData]()
    var isLoading = false
    
    var pagination:Pagination?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NewsFeed"
        self.navigationItem.rightButtonAction(ArticleMNImageDI.barbuttonicon_add.image) { (Void) -> Void in
            (self.actionFloatView.hide(!(self.actionFloatView.isHidden)))
        }
        
        //Init ActionFloatView
        self.actionFloatView = ArticleFloatMenu()
        self.actionFloatView.delegate = self
        self.view.addSubview(self.actionFloatView!)
        self.actionFloatView?.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsMake(64, 0, 0, 0))
        }
        
        //self.view.backgroundColor = UIColor.viewBackgroundColor
        self.newsfeedListView.registerCellNib(NewsfeedTopTableViewCell.self)
        self.newsfeedListView.registerCellNib(NewsfeedTableViewCell.self)
        self.newsfeedListView.tableFooterView = UIView()
        self.newsfeedListView.backgroundColor = UIColor.viewBackgroundColor
        self.newsfeedListView.isScrollEnabled = true
        searchbar = UISearchBar()
        searchbar?.placeholder = "Search"
        self.navigationItem.titleView = searchbar!
        initSearchBar()
        
//        let cgRectNewsfeedList = CGRect(x: 0, y: 0, width: 320, height: 200)
//        self.newsfeedListView = UITableView.init(frame: cgRectNewsfeedList, style: .grouped)
        // Do any additional setup after loading the view.
        
        newsfeedActivityIndicator?.hidesWhenStopped = true
        articlePresenter.attachView(view: self)
       // loadSegment(offset: 1, size: 15)
        articlePresenter.getArticles(page: 1,limit: 15)
        self.newsfeedListView.reloadData()
        self.newsfeedListView.addSubview(self.refreshControl)
        //NotificationCenter.default.addObserver(self, selector: "reloadData:",name:NSNotification.Name(rawValue: "reloadData"), object: nil)
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        articlePresenter.getArticles(page: 1,limit: 15)
        self.newsfeedListView.reloadData()
    }
    

    func handleRefresh(refreshControl: UIRefreshControl) {
        articlePresenter.getArticles(page: 1,limit: 15)
        
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

extension NewsfeedViewController:UISearchBarDelegate,UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func initSearchBar(){
        self.searchbar?.delegate = self
    }
}

extension NewsfeedViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsDetailViewController = NewsDetailViewController.initFromNib() as! NewsDetailViewController
        newsDetailViewController.article = articleData[indexPath.section]
        self.push(newsDetailViewController)
    }
    
}

extension NewsfeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articleData.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 200.0
        }
        return 50.0
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //Bottom Refresh
        print("asdasdas")
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(NewsfeedTopTableViewCell.self)
            let article = articleData[indexPath.section]
        
            
            //let image = ArticleMNImageDI.noimage.image
              //  cell.featureImage.kf.setImage(with: url,placeholder:image)
            if let featureImage = URL(string:article.image!) {
            SonadevImageCacher.sharedInstance.getImage(url: featureImage) { image, error in
                if error != nil {
                    
                } else if let fullImage = image {
                   cell?.featureImage.image = fullImage
                }
            }
            }
            if let authorImage = article.author?.imageUrl {
            SonadevImageCacher.sharedInstance.getImage(url: URL(string: authorImage)!) { image, error in
                if error != nil {
                    
                } else if let fullImage = image {
                    cell?.avatar.image = fullImage
                }
            }
            }
            cell?.title.text = articleData[indexPath.section].title
                return cell!
        }
        else{
        let cell = tableView.dequeueReusableCell(NewsfeedTableViewCell.self)
            print(indexPath.section)
            print(articleData.count)
        cell?.title.text = articleData[indexPath.section].title
            if let featureImage = URL(string:articleData[indexPath.section].image!) {
                SonadevImageCacher.sharedInstance.getImage(url: featureImage, completion: {
                image, error in
                if error != nil{
                
                }else if image != nil {
                    cell?.featureImage.image = image
                }
            })
            }
        return cell!
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        tableView.deselectRow(at: indexPath, animated: true)
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
           let editViewController = WriterViewController.initFromNib() as! WriterViewController
            editViewController.articleViewData = self.articleData[indexPath.section]
            //self.navigationController?.popViewController(animated: true)
            //self.navigationController?.popToViewController(editViewController, animated: true)
            //self.pushWithoutHideTabbar(editViewController, animated: true, hideTabbar: true)
           // self.push(editViewController)
            //editViewController.tabBarController?.selectedIndex = 1
            self.pushWithoutHideTabbar(editViewController, animated: true, hideTabbar: false)
            //self.navigationController?.push(editViewController)
        })
        editAction.backgroundColor = UIColor.blue
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            let session = URLSession(configuration: .default)
            session.synTask(url: URL(string:"\(Config.API_URL)articles/\(self.articleData[indexPath.section].id!)")!, "DELETE", completionHandler: {
                data, response, error in
                if error == nil {
                    //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"),object: self)
                    //self.articlePresenter.attachView(view: self)
                    self.articleData.removeAll()
                    self.articlePresenter.getArticles(page: 1,limit: 15)
                    //self.newsfeedListView.reloadData()
                }else{
                  
                }
            })
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
    }
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        print("work")
    }
    
}

extension NewsfeedViewController: ActionFloatViewDelegate {
    func floatViewTapItemIndex(_ type: ActionFloatViewItemType) {
        switch type {
        case .dateTime:
            print("DateTime")
            break
        case .author:
            print("Author")
            break
        case .title:
            print("Title")
            break
        }
    }
}

extension NewsfeedViewController:ArticleView {
    
    func startLoading() {
        newsfeedActivityIndicator?.startAnimating()
        print("Will start")
    }
    
    func finishLoading() {
        newsfeedActivityIndicator?.stopAnimating()
//        print("Will finish")
//        DispatchQueue.main.async{
//            self.newsfeedListView.reloadData()
//        }
        //self.newsfeedListView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func setArticle(articles: [ArticleViewData], pagination: Pagination) {
        print("Should Work")
        DispatchQueue.main.async{
            self.newsfeedListView.reloadData()
        }

        if self.articleData.count > 0 && isLoading{
            for item in articles {
                let row = self.articleData.count
                    let indexPath = IndexSet(integer: row)
                    self.articleData.append(item)
                    self.newsfeedListView?.insertSections(indexPath, with: UITableViewRowAnimation.fade)
                
            }
        }else{
            self.articleData.removeAll()
            self.articleData = articles
        }
        
        self.isLoading = false
        
        self.pagination = pagination
        newsfeedListView?.isHidden = false
        emptyView?.isHidden = true;
        self.isLoading = false
        DispatchQueue.main.async{
            self.newsfeedListView.reloadData()
        }
    }
    
    func setEmptyArticles() {
        newsfeedListView?.isHidden = true
        emptyView?.isHidden = false
    }
    
    func deleteArticle(id: Int) {
        
    }
    
    
}

extension NewsfeedViewController {
    func loadSegment(offset:Int, size:Int) {
        if (!self.isLoading) {
            self.isLoading = true
            articlePresenter.getArticles(page: offset, limit: size)
        }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Expected that work blog scroll")
        let offset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maxOffset - offset) <= 40 {
            let p = (pagination?.page)!+1
            print("P: \(p)")
            print("TotalPage: \(pagination?.page)")
            if pagination!.total_pages! < p{
                return
            }
            //print(pagination?.page)
            loadSegment(offset: p, size: PageSize)
        }
    }
   
    
    
}

