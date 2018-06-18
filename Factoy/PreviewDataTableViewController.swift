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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load  peview
        createLoadingIndicator()
        LoadPreview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let date = Date()
        print(date)
        let timeToCompare = time.addingTimeInterval(5*60)
        print(timeToCompare)
        if timeToCompare > date {
            return
        } else {
            print("5 minutes has passed, time to reload data! :)")
            LoadPreview()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return previewData.count
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
                    if let image = response.result.value
                    {
                        cell.photoImageView.image = image
                    }

                case .failure(let error):
                    errorOccured(value: error)
                }
            }

        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
            super.prepare(for: segue, sender: sender)
        
            guard let previewDetailViewController = segue.destination as? DataViewController else
            {
                //fatalError("Unexpected destination \(segue.destination)")
                errorOccured(value: "Unexpected destination!")
                return
            }
        
            guard let selectedPreviewCell = sender as? PreviewDataTableViewCell else
            {
                //fatalError("Unexpeced sender: \(sender!)")
                errorOccured(value: "Unexpeced sender!")
                return
            
            }
        
            guard let indexPath = tableView.indexPath(for: selectedPreviewCell) else
            {
                // fatalError("The selected cellis not being displayed by the table")
                errorOccured(value: "The selected cellis not being displayed by the table")
                return
            }
        
            let selectedPreview = previewData[indexPath.row]
            previewDetailViewController.preview = selectedPreview
    }
    
    // MARK: Function for Activity Indicator
    func createLoadingIndicator()
    {
        loadingIndicator.center = view.center
        loadingIndicator.color = UIColor.blue
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
    }
    
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
                
                self.tableView.reloadData()
                self.refresher.endRefreshing()
                self.loadingIndicator.stopAnimating()
                
            }
    }
    

    
}

