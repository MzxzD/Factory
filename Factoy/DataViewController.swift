//
//  ViewController.swift
//  Factoy
//
//  Created by Mateo Došlić on 06/06/2018.
//  Copyright © 2018 Mateo Došlić. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DataViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView?
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var storyText: UITextView!
    
    var newsToDisplay: NewsViewData? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD

        if let preview = preview
        {
            navigationItem.title = preview.headline
            headlineLabel.text = preview.headline
            // photoImageView.image = preview.photo
            storyText.text = preview.story
            
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
                            self.photoImageView.image = image
                        }
                        
                    case .failure(let error):
                        errorOccured(value: error)
                    }
            }
            
        } else
        {
            errorOccured()
        }
    }
=======
        
        Alamofire.request(URL (string: newsToDisplay!.image_url)!).responseImage
                {
                    response in
                        if let image = response.result.value
                        {
                            self.photoImageView?.image = image
                        }
                }
        headlineLabel.text = newsToDisplay?.headline
        storyText.text = newsToDisplay?.story
    }
            
    
    
>>>>>>> Experimental
}

