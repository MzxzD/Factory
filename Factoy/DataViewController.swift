//
//  ViewController.swift
//  Factoy
//
//  Created by Mateo Došlić on 06/06/2018.
//  Copyright © 2018 Mateo Došlić. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var storyText: UITextView!
    
    var preview: Preview?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let preview = preview
        {
            navigationItem.title = preview.headline
            headlineLabel.text = preview.headline
            photoImageView.image = preview.photo
            storyText.text = preview.story
            
        } else
        {
            errorOccured()
        }
    }
}

