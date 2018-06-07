//
//  PreviewDataTableViewController.swift
//  Factoy
//
//  Created by Mateo Došlić on 07/06/2018.
//  Copyright © 2018 Mateo Došlić. All rights reserved.
//

import UIKit

class PreviewDataTableViewController: UITableViewController {

    
    // MARK: Properties
    
    var PreviewData = [Preview]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Load sample pewview
        loadSamplePreview()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        return PreviewData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cell are used and should be dequeued using a cell identifier
        let cellIdentifier = "PreviewDataTableViewCell"
        
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PreviewDataTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            
        }
        
        let preview = PreviewData[indexPath.row]
        
        cell.headlineLabel.text = preview.headline
        cell.photoImageView.image = preview.photo
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let previewDetailViewController = segue.destination as? DataViewController else {
            fatalError("Unexpected destination \(segue.destination)")
        }
        
        guard let selectedPreviewCell = sender as? PreviewDataTableViewCell else {
            fatalError("Unexpeced sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedPreviewCell) else {
            fatalError("The selected cellis not being displayed by the table")
        }
        
        let selectedPreview = PreviewData[indexPath.row]
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
        
        
        
        
        
        
         PreviewData += [preview1, preview2, preview3]
    }
    
    

}
