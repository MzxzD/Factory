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

let url = "https://newsapi.org/v1/articles?apiKey=6946d0c07a1c4555a4186bfcade76398&sortBy=top&source=bbc-news"


class PreviewDataTableViewController: UITableViewController {

    
    // MARK: Properties
    
    var previewData = [Preview]()
    var picture: UIImage?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load  peview
        LoadPreview()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return previewData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cell are used and should be dequeued using a cell identifier
        let cellIdentifier = "PreviewDataTableViewCell"
        
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PreviewDataTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            
        }
        
        let preview = previewData[indexPath.row]
        
        cell.headlineLabel.text = preview.headline
        cell.photoImageView.image = preview.photo
        

        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let previewDetailViewController = segue.destination as? DataViewController else {
            fatalError("Unexpected destination \(segue.destination)")
        }
        
        guard let selectedPreviewCell = sender as? PreviewDataTableViewCell else {
            fatalError("Unexpeced sender: \(sender!)")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedPreviewCell) else {
            fatalError("The selected cellis not being displayed by the table")
        }
        
        let selectedPreview = previewData[indexPath.row]
         previewDetailViewController.preview = selectedPreview 
    }
 
    
    
    
    
    // MARK: private methods
    
    private func loadSamplePreview() {
        
        let photo1 = UIImage(named: "Image1")
        let photo2 = UIImage(named: "Image2")
        let photo3 = UIImage(named: "Image3")
        
        guard let preview1 = Preview(headline: "Beautiful park preview", photo: photo1, story:" Join us in opening the Celebration in the Oaks season. The parties are always a blast and you get to view all the traditions youve come to know and expect as well as see what's new before everyone else! Click the boxes below to find out more about the parties, entertainment, cuisine, and to buy tickets.*Tickets for Celebration in the Oaks and Preview Parties are on sale now! Click here if you already know which party tickets you wish to purchase.** ") else {
            fatalError("Unable to instantianite preview1")
            
           
        }
        guard let preview2 = Preview(headline: "Best Bridge in Croatia", photo: photo2, story:" Join us in opening the Celebration in the Oaks season. The parties are always a blast and you get to view all the traditions youve come to know and expect as well as see what's new before everyone else! Click the boxes below to find out more about the parties, entertainment, cuisine, and to buy tickets.*Tickets for Celebration in the Oaks and Preview Parties are on sale now! Click here if you already know which party tickets you wish to purchase.** ") else {
            fatalError("Unable to instantianite preview1")
            
            
        }
        
        guard let preview3 = Preview(headline: "Historical Houses are comming back!", photo: photo3, story:" Join us in opening the Celebration in the Oaks season. The parties are always a blast and you get to view all the traditions youve come to know and expect as well as see what's new before everyone else! Click the boxes below to find out more about the parties, entertainment, cuisine, and to buy tickets.*Tickets for Celebration in the Oaks and Preview Parties are on sale now! Click here if you already know which party tickets you wish to purchase.** ") else {
            fatalError("Unable to instantianite preview1")
            
            
        }
        
         previewData += [preview1, preview2, preview3]
    }

    // MARK: Function for loading Data from URL
    private func LoadPreview() {

        // Validating URL response
        Alamofire.request(url).validate().responseJSON { response in
            
            switch response.result {
                
            case .success:
                print("Validation Successful")
               
                
                // Parsing data
                let JSON = response.result.value as! [String: Any]
                let JSONArticles = JSON["articles"] as! NSArray
                for Articles in JSONArticles {
                    
                    // Saving important values
                    var Values = Articles as! [String: String]
                    let headline = Values["title"] as! String
                    let photo_string = Values["urlToImage"] as! String
                    var story = Values["description"] as! String
                    story += "\n"
                    story += Values["url"] as! String

                    let photoURL = URL(string: photo_string)
                    
                    Alamofire.request(photoURL!).responseImage { response in
                        
                        if let image = response.result.value {
                            print("image downloaded: \(image)")
                            // Saving Values in preview Object
                            guard let previewx = Preview(headline: headline, photo: image, story: story)
                                else {
                                    fatalError("Unable to instantianite preview")
                            }
                            self.previewData += [previewx]
                            DispatchQueue.main.async{
                                self.tableView.reloadData()
                            }
                        }
                    }
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}
