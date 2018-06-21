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
<<<<<<< HEAD
    
    // MARK: Properties
    

    */
    
    let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    fileprivate let newsPresenter = NewsPresenter(newsService: NewsService())
    fileprivate var newsToDisplay = [NewsViewData]()
>>>>>>> Experimental
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsPresenter.attachView(self)
        newsPresenter.getNews()

    }
 
    override func viewDidAppear(_ animated: Bool) {
        newsPresenter.checkTimer(time: Date())
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
<<<<<<< HEAD
        let preview = previewData[indexPath.row]
        
        cell.headlineLabel.text = preview.headline
        
        // Downloading image from saved link
        Alamofire.request(URL (string: preview.photo_url)!)
            .validate()
            .responseImage
            {
                response in
                switch response.result
                {
                    
                case .success:
=======
        let newsViewData = newsToDisplay[indexPath.row]
        
        cell.headlineLabel.text = newsViewData.headline
        Alamofire.request(URL (string: newsViewData.image_url)!).responseImage
            {
                response in
>>>>>>> Experimental
                    if let image = response.result.value
                    {
                        cell.photoImageView.image = image
                    }
<<<<<<< HEAD

                case .failure(let error):
                    errorOccured(value: error)
                }
            }

        return cell
=======
            }
        return  cell
>>>>>>> Experimental
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
                newsDetailViewController.newsToDisplay = selectedNews
    }


}

extension PreviewDataTableViewController: NewsView {
 
    func startLoading() {
        loadingIndicator.center = view.center
        loadingIndicator.color = UIColor.blue
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
    }
    
<<<<<<< HEAD
    // MARK: Function for loading Data from URL
    @objc func LoadPreview()
    {
        if (!previewData.isEmpty)
        {
            previewData.removeAll()
        }
        // Getting a "timestamp"
        let time_now = Date()
        
        // Validating URL response
        let url = "https://newsapi.org/v1/articles?apiKey=6946d0c07a1c4555a4186bfcade76398&sortBy=top&source=bbc-news"
        Alamofire.request(url)
            .validate()
            .responseJSON
            {
                response in
                
                switch response.result
                {
                    case .success:
                        print("Validation Successful")
                        
                        // Parsing data
                        let JSON = response.result.value as! [String: Any]
                        let JSONArticles = JSON["articles"] as! NSArray
                        for Articles in JSONArticles
                        {
                            // Saving important values
                            var Values = Articles as! [String: String]
                            let headline = (Values["title"] as String?) ?? ""
                            let photo_url = (Values["urlToImage"] as String?) ?? ""
                            let story = (Values["description"] as String?) ?? ""

                            guard let preview = Preview(headline: headline, photo_url: photo_url, story: story) else
                            {
                                errorOccured()
                                return
                            }
                            self.previewData += [preview]
                            
                        }
                    
                    case .failure(let error):
                        errorOccured(value: error)
                }
                self.time = time_now
                print("Time view is created: \(self.time)")
                self.refresher.endRefreshing()
                self.tableView.reloadData()
                self.loadingIndicator.stopAnimating()
                
            }
    }
    

=======
    func fininshLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func setNews(_ news: [NewsViewData]) {
        newsToDisplay = news
        tableView?.isHidden = false
        tableView?.reloadData()
    }
    
    func setEmptyNews() {
        tableView.isHidden = true
        errorOccured(value: "No news has been loaded :(")
    }
    
    
}


