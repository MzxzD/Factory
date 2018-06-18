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
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var storyText: UITextView!
    
    var photoImage_url = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
            Alamofire.request(URL (string: photoImage_url)!).responseImage
                {
                    response in
                        if let image = response.result.value
                        {
                            self.photoImageView.image = image
                        }
                }
    }
            
    
    
}

