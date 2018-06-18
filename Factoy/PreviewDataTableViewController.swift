//
//  PreviewDataTableViewController.swift
//  Factoy
//
//  Created by Mateo Došlić on 07/06/2018.
//  Copyright © 2018 Mateo Došlić. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class PreviewDataTableViewController: UITableViewController {
    /*
    // MARK: Properties
    let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var previewData = [Preview]()
    var time = Date()
    
   
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(LoadPreview), for: .valueChanged)
        return refreshControl
    }()
    */
    
    fileprivate let newsPresenter = NewsPresenter(newsService: NewsService())
    fileprivate var newsToDisplay = [NewsViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView?.dataSource = self
        
        
        // newsPresenter.attachView(self)
        newsPresenter.getNews()
  /*
        //Load  peview
        createLoadingIndicator()
        LoadPreview() */
    }
 
    override func viewDidAppear(_ animated: Bool) {
    /*    let date = Date()
        print(date)
        let timeToCompare = time.addingTimeInterval(5*60)
        print(timeToCompare)
        if timeToCompare > date {
            return
        } else {
            print("5 minutes has passed, time to reload data! :)")
            LoadPreview()
        }*/
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsToDisplay.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        // Table view cell are used and should be dequeued using a cell identifier
        let cellIdentifier = "PreviewDataTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PreviewDataTableViewCell else
        {
            //fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            errorOccured(value: "The dequeued cell is not an instance of MealTableViewCell.")
            return UITableViewCell()
           
        }
        let newsViewData = newsToDisplay[indexPath.row]
        
        cell.headlineLabel.text = newsViewData.headline
        Alamofire.request(URL (string: newsViewData.image_url)!).responseImage
            {
                response in
                    if let image = response.result.value
                    {
                        cell.photoImageView.image = image
                    }
            }
        return  cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
            super.prepare(for: segue, sender: sender)
        
            guard let newsDetailViewController = segue.destination as? DataViewController else
            {
                //fatalError("Unexpected destination \(segue.destination)")
                errorOccured(value: "Unexpected destination!")
                return
            }
        
            guard let selectedNewsCell = sender as? PreviewDataTableViewCell else
            {
                //fatalError("Unexpeced sender: \(sender!)")
                errorOccured(value: "Unexpeced sender!")
                return
            
            }
        
            guard let indexPath = tableView.indexPath(for: selectedNewsCell) else
            {
                // fatalError("The selected cellis not being displayed by the table")
                errorOccured(value: "The selected cellis not being displayed by the table")
                return
            }
        
             let selectedNews = newsToDisplay[indexPath.row]
                newsDetailViewController.headlineLabel.text = selectedNews.headline
                newsDetailViewController.storyText.text = selectedNews.story
                newsDetailViewController.photoImage_url = selectedNews.image_url
    }
    
    

    
    
 /*
    // MARK: Function for Activity Indicator
    func createLoadingIndicator()
    {
        loadingIndicator.center = view.center
        loadingIndicator.color = UIColor.blue
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
    }
    
*/

}

extension PreviewDataTableViewController: NewsView {
    func startLoading() {
       // activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
      //  activityIndicator?.stopAnimating()
    }
    
    func setUsers(_ news: [NewsViewData]) {
        newsToDisplay = news

        tableView?.reloadData()
    }
    
    func setEmptyUsers() {

    }
    
}


