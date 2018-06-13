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
    
    var newsData: [Articles] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load News
        LoadNews()

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

    // MARK: Function for loading Data from URL
    private func LoadNews() {
        let url = URL(string: "https://newsapi.org/v1/articles?apiKey=6946d0c07a1c4555a4186bfcade76398&sortBy=top&source=bbc-news")
        Alamofire.request(url!).responseJSON { (response) in
            let result = response.data
            do {
                let data = try JSONDecoder().decode(News.self, from: result!)
                self.newsData = data.articles
                DispatchQueue.main.async {
                    
                    
                    self.tableView.reloadData()
                }
            }catch {
                print("error")
            }
            
        }
        
        
    }
}
