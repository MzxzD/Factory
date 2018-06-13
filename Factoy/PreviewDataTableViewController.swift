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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load  peview
        createLoadingIndicator()
        LoadPreview()
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
        cell.photoImageView.image = preview.photo
        
        
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
    private func LoadPreview()
    {
        
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
                            let headline = Values["title"] as String?
                            let photo_string = Values["urlToImage"] as String?
                            let story = Values["description"] as String?
                            let photoURL = URL(string: photo_string!)
                            
                            Alamofire.request(photoURL!)
                                .responseImage
                                {
                                    response in
                                        if let image = response.result.value
                                        {
                                            // Saving Values in preview Object
                                            guard let previewx = Preview(headline: headline!, photo: image, story: story!)
                                                else {
                                                    //fatalError("Unable to instantianite preview")
                                                    errorOccured()
                                                    return
                                                    }
                                            self.previewData += [previewx]
                                        }
                                        self.loadingIndicator.stopAnimating()
                                        self.tableView.reloadData()
                                }
                        }
                    
                    case .failure(let error):
                        errorOccured(value: error)
                }
            }
    }
    
    
    
}

